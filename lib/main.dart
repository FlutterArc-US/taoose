import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

var chatEnabled = false;
final newNotificationNotifier = ValueNotifier<bool>(false);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Background notification: ${message.data}");
  print('Handling a background message ${message.data}');
}

void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
  newNotificationNotifier.value = true;
  log("Background notification:....... ${response?.actionId}");
  print('Handling a background message.......... ${response?.actionId}');
}

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
    scheduleMicrotask(() {
      initData();
    });
  }

  Future<void> initData() async {
    await getFcmToken();
    await readyNotificationSystem();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      Get.toNamed(
        AppRoutes.notificationsScreen,
      );
    },
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
    var user = FirebaseAuth.instance.currentUser;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print(message.data);
      if (chatEnabled && message.data['type'] == 'message') {
        return;
      }

      if (notification != null && android != null) {
        print('222');

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
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        Future.delayed(const Duration(microseconds: 500), () {
          // Navigator.push(
          //     navigatorKey.currentState?.context ?? context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             Material(child: NotificationsScreen())));
        });

        // showDialog(
        //     context: navigatorKey.currentState?.context ?? context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(notification.title!),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [Text(notification.body!)],
        //           ),
        //         ),
        //       );
        //     });
      }
    });
    print('111');
  }

  Future<void> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var user = FirebaseAuth.instance.currentUser;

    if (fcmToken != null && user != null) {
      FirebaseFirestore.instance
          .collection('TaousUser')
          .doc(user.uid.toString())
          .set({
        'fcmTokens': FieldValue.arrayUnion([fcmToken])
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
            dividerColor: Colors.transparent,
            colorScheme: ThemeData(
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: ColorConstant.teal200))
                .colorScheme
                .copyWith(primary: ColorConstant.teal200)),
        translations: AppLocalization(),
        locale: Get.deviceLocale,
        //for setting localization strings
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
