// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:garage/core/storage/preference_manager.dart';
// import 'package:garage/routes/app_pages.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.data}");
// }

// class FirebaseNotifications {
//   FirebaseMessaging? _firebaseMessaging;

//   FlutterLocalNotificationsPlugin? _notificationsPlugin;

//   Map<String, dynamic>? _not;

//   String channelName = "CHANNEL_POLICE_STEAK";

//   Future<void> setUpFirebase() async {
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//     _firebaseMessaging = FirebaseMessaging.instance;
//     _firebaseMessaging?.setAutoInitEnabled(true);
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//     checkLastMessage();
//     firebaseCloudMessaging_Listeners();

//     _notificationsPlugin = FlutterLocalNotificationsPlugin();

//     _notificationsPlugin
//         ?.resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var ios = const DarwinInitializationSettings(
//         requestSoundPermission: true,
//         defaultPresentBadge: true,
//         defaultPresentAlert: true,
//         defaultPresentSound: true);
//     var initSetting = InitializationSettings(android: android, iOS: ios);
//     _notificationsPlugin?.initialize(initSetting,
//         onDidReceiveNotificationResponse: (response) =>
//             onSelectNotification(response.payload));
//   }

//   Future<void> checkLastMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       print(initialMessage.data.toString());
//       handlePath(initialMessage.data);
//     }
//   }

//   Future<void> firebaseCloudMessaging_Listeners() async {
//     if (Platform.isIOS) iOS_Permission();

//     _firebaseMessaging?.getToken().then((token) {
//       print("TOOOKEN: $token");
//       Get.find<PreferenceManager>().saveFCMToken(token ?? "");
//       // GetStorage().write(CachingKey.DEVICE_TOKEN, token);
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage data) {
//       print('on message ' + data.data.toString());
//       print('on message ' + data.notification.toString());
//       _not = data.data;
//       if (Platform.isAndroid) {
//         showNotification(data.data, data.notification?.title ?? "",
//             data.notification?.body ?? "");
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
//       print('on Opened ' + data.data.toString());

//       handlePath(data.data);
//     });

// //     _firebaseMessaging.configure(
// //       onMessage: (Map<String, dynamic> message) async {
// //
// //         // _onMessageStreamController.add(message);
// //         // FlutterRingtonePlayer.playNotification(
// //         //   volume: 50,
// //         //   asAlarm: true,
// //         // );
// //       },
// //       onResume: (Map<String, dynamic> message) async {
// //         print('on resume $message');
// // //        navigatorKey.currentState.pushNamed("screen");
// // //        _onMessageStreamController.add(message);
// // //        FlutterRingtonePlayer.playNotification(
// // //          volume: 50,
// // //          asAlarm: true,
// // //        );
// //       },
// //       onLaunch: (Map<String, dynamic> message) async {
// //         print('on launch $message');
// // //        _onMessageStreamController.add(message);
// // //        FlutterRingtonePlayer.playNotification(
// // //          volume: 50,
// // //          asAlarm: true,
// // //        );
// //         handlePath(message);
// //       },
// //     );
//   }

//   showNotification(
//       Map<String, dynamic> _message, String title, String body) async {
//     print("Notification Response : $_message");

//     var androidt = AndroidNotificationDetails('12', channelName,
//         priority: Priority.max,
//         channelShowBadge: true,
//         playSound: true,
//         ticker: 'ticker',
//         icon: "@mipmap/launcher_icon",
//         enableVibration: true,
//         enableLights: true,
//         importance: Importance.max);
//     var iost = const DarwinNotificationDetails();
//     var platform = NotificationDetails(android: androidt, iOS: iost);
//     await _notificationsPlugin?.show(0, title, body, platform, payload: "");
//   }

//   void iOS_Permission() {
//     _firebaseMessaging?.requestPermission(
//         alert: true, announcement: true, badge: true, sound: true);
//     // _firebaseMessaging.requestNotificationPermissions(
//     //     IosNotificationSettings(sound: true, badge: true, alert: true));
//     // _firebaseMessaging.onIosSettingsRegistered
//     //     .listen((IosNotificationSettings settings) {
//     //   print("Settings registered: $settings");
//     // });
//   }

//   void handlePath(Map<String, dynamic>? dataMap) {
//     handlePathByRoute(dataMap);
//   }

//   Future<void> handlePathByRoute(Map<String, dynamic>? dataMap) async {
//     // String type = dataMap["key"].toString();
//     // var keyId = dataMap['key_id'].toString();
//     // NotificationData notificationData = NotificationData.fromJson(dataMap);

//     Get.toNamed(Routes.HOME);
//   }

//   Future? onSelectNotification(String? payload) {
//     print(payload.toString());
//     handlePath(_not);
//     return null;
//   }
// }
