import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taousapp/core/constants/color_constant.dart';
import 'package:taousapp/notifications/domain/usecases/enable_notification_setting.dart';
import 'package:taousapp/notifications/domain/usecases/initialize_local_notification.dart';
import 'package:taousapp/util/di/di.dart';

import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';

import 'notifications/presentation/providers/enable_notification_setting_provider.dart';
import 'notifications/presentation/providers/initialize_local_notification_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await CountryCodes.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  //'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Future<void> readyNotificationSystem() async {
    await enableNotificationPermission();
    await initializeLocalNotification();
  }

  Future<void> enableNotificationPermission() async {
    try {
      final enableNotificationSettingUsecase =
          sl<EnableNotificationSettingUsecase>();
      await enableNotificationSettingUsecase(
        EnableNotificationSettingUsecaseInput(),
      );
    } catch (_) {}
  }

  Future<void> initializeLocalNotification() async {
    try {
      final initializeLocalNotificationUsecase =
          sl<InitializeLocalNotificationUsecase>();

      await initializeLocalNotificationUsecase(
        InitializeLocalNotificationUsecaseInput(),
      );
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    getFcmToken();
    readyNotificationSystem();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    var user = FirebaseAuth.instance.currentUser;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('222');
        try {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  //channel.description,
                  color: Colors.white.withOpacity(0),
                  // ignore: todo
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: "@mipmap/ic_launcher",
                  enableVibration: true,
                ),
              ));
        } catch (e) {
          print(e);
        }
        if (user != null) {
          var reference1 = FirebaseFirestore.instance
              .collection('TaousUser')
              .doc(user.uid.toString());

          var doc1 = await reference1.get();
          if (doc1.exists) {
            reference1.update({
              'notifications': FieldValue.arrayUnion(
                [
                  {
                    'id': channel.id,
                    'timestamp': DateTime.now(),
                    'notification': [notification.title, notification.body]
                  }
                ],
              )
            });
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    print('111');
    getFcmToken();
  }

  Future<void> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var user = FirebaseAuth.instance.currentUser;

    if (fcmToken != null && user != null) {
      FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(user.uid.toString())
          .set({'fcmToken': fcmToken}, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
            dividerColor: Colors.transparent,
            colorScheme: ThemeData(
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: ColorConstant.teal200))
                .colorScheme
                .copyWith(primary: ColorConstant.teal200)),
        translations: AppLocalization(),
        locale: Get.deviceLocale, //for setting localization strings
        fallbackLocale: Locale('en', 'US'),
        title: 'taousapp',
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
        builder: ((context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        }),
      ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    var reference1 = FirebaseFirestore.instance
        .collection('TaousUser')
        .doc(user.uid.toString());

    var doc1 = await reference1.get();
    if (doc1.exists) {
      reference1.update({
        'notifications': FieldValue.arrayUnion(
          [
            {
              'id': channel.id,
              'timestamp': DateTime.now(),
              'notification': [
                message.notification?.title,
                message.notification?.body
              ]
            }
          ],
        )
      });
    }
  }
  print('sdsdsdsdsdsdsds');
  print('Handling a background message ${message.notification?.body}');
}
