// // ignore_for_file: prefer_const_declarations, unused_element, avoid_print

// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FcmFunctions {
//   //fcm notification on minimize app
//   // FirebaseMessaging.onMessageOpenedApp.listen((message) async {
//   //   print('Got a message whilst in the minimize');
//   //   if (message.data['order_id'] != null) {
//   //     print('working in if ');
//   //     print('Message data: ${message.data}');
//   //     // await myOrderController.myOrder(message.data['order_id'].toString());
//   //     print(
//   //         'Message also contained a notification: ${message.notification!.body}');
//   //   } else {
//   //     // showNotification(message.notification!.title.toString(),
//   //     //     message.notification!.body.toString());
//   //   }
//   // });

//   //fcm notification on opened app

//   // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//   //   if (message.notification != null) {
//   //     FcmFunctions.showNotification(message.notification!.title.toString(),
//   //         message.notification!.body.toString());
//   //     print(message.notification);
//   //   } else {
//   //     // showNotification(message.notification!.title.toString(),
//   //     // message.notification!.body.toString());
//   //   }
//   // });

//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print('this is message ${message.data}');
//     // showNotification(
//     //     message.data['title'].toString(), message.data['body'].toString());
//   }

//   static Future selectNotification(payload) async {
//     // if (payload != null) {
//     //   Get.to(DashboardScreen(index: 1));
//     // }
//     print('this is local notification in background');
//     print("gooing to orderListScreen");
//   }

//   static Future forgroundNotification(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     debugPrint('notification payload: $payload');
//     print('this is local notification in forground');
//     print("going to orderListScreen");
//   }

//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static showNotification(String title, String body) async {
//     try {
//       print("In Notification method");
//       Random random = Random();
//       int id = random.nextInt(1000);
//       final NotificationDetails notificationDetails = const NotificationDetails(
//           android: AndroidNotificationDetails("Bliksy", "App",
//               importance: Importance.high,
//               priority: Priority.high,
//               fullScreenIntent: true,
//               playSound: true,
//               timeoutAfter: 5000));
//       print("my id is ${id.toString()}");
//       await flutterLocalNotificationsPlugin.show(
//         id,
//         title,
//         body,
//         notificationDetails,
//       );
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//   }
// }
