import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taousapp/presentation/home_screen/controller/home_controller.dart';
import 'package:taousapp/presentation/post_screen/models/comment_model.dart';

import '../../post_screen/controller/post_controller.dart';
import '../controllers/comments_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsView extends GetView<CommentsController> {
  CommentsView({Key? key}) : super(key: key);

  var postData = Get.arguments;
  final currentUser = Get.find<HomeController>().auth.currentUser!.uid;

  final commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Post Comments',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.listenToComments(
                  postOwnerId: postData['owner'],
                  postId: postData['postId'],
                  category: postData['description'],
                ),
                builder: (
                  context,
                  AsyncSnapshot<List<CommentModel>> comments,
                ) {
                  if (!comments.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: comments.data!.length,
                    itemBuilder: (context, index) {
                      final item = comments.data![index];
                      return CommentBox(item, postData);
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: commentTextController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Write comment",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.writeComment(
                      postId: postData['postId'],
                      comment: commentTextController.text,
                      myUserId: currentUser,
                      category: postData['description'],
                      postOwnerUserId: postData['owner'],
                    );
                    commentTextController.clear();
                  },
                  icon: Icon(Icons.send),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  final CommentModel item;
  final data;

  CommentBox(this.item, this.data, {super.key});

  final postController = Get.find<PostController>();
  final controller = Get.find<CommentsController>();
  final homeController = Get.find<HomeController>();

  final textEditingController = TextEditingController();
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postController.getUserDetails(item.commentedBy),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final user = snapshot.data!;
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(user['fullName'][0]),
              ),
              title: Text(user['fullName']),
              subtitle: Text(item.comment),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TimeAgoWidget(item.time),
                TextButton(
                  onPressed: () {
                    controller.replyingTo.value = item.id;
                    focus.requestFocus();
                  },
                  child: const Text(
                    'Reply',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.replyingTo.value != item.id
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Reply comment',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (textEditingController.text.isEmpty) {
                                return;
                              }

                              controller.writeSubComment(
                                postId: data['postId'],
                                commentId: item.id,
                                comment: textEditingController.text,
                                myUserId: homeController.auth.currentUser!.uid,
                                category: data['description'],
                                postOwnerId: data['owner'],
                                commentOwnerId: item.commentedBy,
                              );
                              textEditingController.clear();
                            },
                            icon: Icon(
                              Icons.reply,
                              color: Colors.grey[600],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
            StreamBuilder(
              stream: controller.listenToSubComments(
                postOwnerId: data['owner'],
                postId: data['postId'],
                category: data['description'],
                commentId: item.id,
              ),
              builder:
                  (context, AsyncSnapshot<List<CommentModel>> subComments) {
                if (!subComments.hasData) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    for (final subComment in subComments.data!)
                      FutureBuilder(
                        future: postController
                            .getUserDetails(subComment.commentedBy),
                        builder: (context, subBy) {
                          if (!subBy.hasData) {
                            return const SizedBox();
                          }

                          final subByUser = subBy.data!;

                          return Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text(subByUser['fullName'][0]),
                                  ),
                                  title: Text(subByUser['fullName']),
                                  subtitle: Text(subComment.comment),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TimeAgoWidget(subComment.time),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            )
          ],
        );
      },
    );
  }
}

class TimeAgoWidget extends StatefulWidget {
  final String formatedTime;

  TimeAgoWidget(this.formatedTime);

  @override
  State<TimeAgoWidget> createState() => _TimeAgoWidgetState();
}

class _TimeAgoWidgetState extends State<TimeAgoWidget> {
  @override
  void initState() {
    super.initState();
    update();
  }

  Future<void> update() async {
    await Future.delayed(const Duration(seconds: 10));
    if (mounted) {
      setState(() {});
      update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(DateTime.parse(widget.formatedTime)),
      style: TextStyle(color: Colors.grey[400], fontSize: 12),
    );
  }
}
