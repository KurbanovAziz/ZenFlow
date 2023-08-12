import 'dart:io';

import 'package:zen_flow/Utils/app_imports/app_imports.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// create an instance
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin fltNotification =
    FlutterLocalNotificationsPlugin();
FlutterLocalNotificationsPlugin rideNotification =
    FlutterLocalNotificationsPlugin();
bool isGeneral = false;
String latestNotification = '';
int id = 0;

void notificationTapBackground(NotificationResponse notificationResponse) {
  isGeneral = true;
  // valueNotifierHome.incrementNotifier();
}

var androidDetails = const AndroidNotificationDetails(
  '54321',
  'normal_notification',
  enableVibration: true,
  enableLights: true,
  importance: Importance.high,
  playSound: true,
  priority: Priority.high,
  visibility: NotificationVisibility.public,
);

const iosDetails = DarwinNotificationDetails(
    presentAlert: true, presentBadge: true, presentSound: true);

var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

var androiInit =
    const AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
var iosInit = const DarwinInitializationSettings(
  defaultPresentAlert: true,
  defaultPresentBadge: true,
  defaultPresentSound: true,
);
var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('payload ${message.data}');
  debugPrint('_firebaseMessagingBackgroundHandler');
  // Get.put(NotificationController()).getNotifications();
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    if (message.data['push_type'].toString() == 'general') {
      latestNotification = message.data['message'];
      if (message.data['image'].isNotEmpty) {
        _showBigPictureNotificationURLGeneral(message.data);
      } else {
        _showGeneralNotification(message.data);
      }
    } else {
      _showRideNotification(message.notification);
    }
  }

  // _showGeneralNotification(message.data);
  // showNotification(message.notification!.title.toString(),
  //     message.notification!.body.toString(),message);
}

Future<void> initMessaging() async {
  await fltNotification.initialize(initSetting);
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message?.data != null) {
      if (message?.data['push_type'] == 'general') {
        latestNotification = message?.data['message'];
        isGeneral = true;
        // valueNotifierHome.incrementNotifier();
      }
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      if (message.data['push_type'].toString() == 'general') {
        latestNotification = message.data['message'];
        if (message.data['image'].isNotEmpty) {
          _showBigPictureNotificationURLGeneral(message.data);
        } else {
          _showGeneralNotification(message.data);
        }
      } else {
        _showRideNotification(message.notification);
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.data['push_type'].toString() == 'general') {
      latestNotification = message.data['message'];
      isGeneral = true;
      // valueNotifierHome.incrementNotifier();
    }
  });

  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM Token: $token');
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

Future<void> _showBigPictureNotificationURLGeneral(message) async {
  debugPrint('_showBigPictureNotificationURLGeneral');

  latestNotification = message['message'];
  if (GetPlatform.isAndroid) {
    final ByteArrayAndroidBitmap bigPicture =
        ByteArrayAndroidBitmap(await _getByteArrayFromUrl(message['image']));
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'notification_1',
      'general image notification',
      channelDescription: 'general notification with image',
      styleInformation: bigPictureStyleInformation,
      enableVibration: true,
      enableLights: true,
      importance: Importance.high,
      playSound: true,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    fltNotification.initialize(initSetting,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    await fltNotification.show(
        id++, message['title'], message['message'], notificationDetails);
  } else {
    final String bigPicturePath = await _downloadAndSaveFile(
        Uri.parse(message['image']).toString(), 'bigPicture.jpg');
    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(
            bigPicturePath,
          )
        ]);

    final NotificationDetails notificationDetails =
        NotificationDetails(iOS: iosDetails);
    fltNotification.initialize(initSetting,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    await fltNotification.show(
        id++, message['title'], message['message'], notificationDetails);
  }
  id = id++;
}

Future<void> _showGeneralNotification(message) async {
  debugPrint('_showGeneralNotification');

  latestNotification = message['message'];
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'notification_1',
    'general notification',
    channelDescription: 'general notification',
    enableVibration: true,
    enableLights: true,
    importance: Importance.high,
    playSound: true,
    priority: Priority.high,
    visibility: NotificationVisibility.public,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails, iOS: iosDetails);
  fltNotification.initialize(initSetting,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  await fltNotification.show(
      id++, message['title'], message['message'], notificationDetails);
  id = id++;
}

Future<void> _showRideNotification(message) async {
  debugPrint('_showRideNotification');
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'notification_1',
    'ride notification',
    channelDescription: 'ride notification',
    enableVibration: true,
    enableLights: true,
    importance: Importance.high,
    playSound: true,
    priority: Priority.high,
    visibility: NotificationVisibility.public,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails, iOS: iosDetails);
  rideNotification.initialize(initSetting);
  await rideNotification.show(id++, message.title.toString(),
      message.body.toString(), notificationDetails);
  id = id++;
}
