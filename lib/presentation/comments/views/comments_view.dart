import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taousapp/core/app_export.dart';
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
                    padding: const EdgeInsets.only(top: 10),
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
                    if (commentTextController.text.trim().isEmpty) {
                      return;
                    }

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
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgProfile,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (user['fullName'] as String).capitalizeFirst!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(item.comment),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            controller.replyingTo.value = item.id;
                            focus.requestFocus();
                          },
                          child: Obx(
                            () => Text(
                              'Reply',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: controller.replyingTo.value == item.id
                                    ? Colors.blue
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
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
                              child: Container(
                                height: 35,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: textEditingController,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 17),
                                      hintText: 'Reply comment',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (textEditingController.text.trim().isEmpty) {
                                  return;
                                }

                                controller.writeSubComment(
                                  postId: data['postId'],
                                  commentId: item.id,
                                  comment: textEditingController.text,
                                  myUserId:
                                      homeController.auth.currentUser!.uid,
                                  category: data['description'],
                                  postOwnerId: data['owner'],
                                  commentOwnerId: item.commentedBy,
                                );
                                textEditingController.clear();
                                controller.replyingTo.value = "";
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
                  if (!subComments.hasData ||
                      subComments.hasError ||
                      subComments.data!.isEmpty) {
                    return const SizedBox();
                  }

                  return Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 5),
                          child: Column(
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

                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgAvatar,
                                              height: 25,
                                              width: 25,
                                            ),
                                            const SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        (subByUser['fullName']
                                                                as String)
                                                            .capitalizeFirst!,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(subComment.comment),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TimeAgoWidget(subComment.time),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
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
