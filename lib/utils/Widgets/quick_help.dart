// import 'dart:async';
// import 'dart:convert';
// import 'package:animator/animator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:ntp/ntp.dart';
// import 'package:timezone/standalone.dart' as tz;
// import 'package:dio/dio.dart' as dio;
// //import 'package:timezone/browser.dart' as tz;
// import 'package:universal_platform/universal_platform.dart';
//
// import 'Constants/Api/Api_Manager.dart';
// import 'TimezoneDateModel/TimeZoneDate.dart';
// import 'Widgets/customSnakbar.dart';
//
// class QuickHelp {
//   /// Construct a color from a hex code string, of the format #RRGGBB.
//   static Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//   }
//
//   static String getOddsPercentage(
//       {var totalBids, var oddPercentage, var isPercentage = false}) {
//     // debugPrint('totalBids : $totalBids -- oddPercentage $oddPercentage -- ');
//     // print("i am called getOddsPercentage $totalBids $oddPercentage}");
//     if (isPercentage) {
//       return int.parse(totalBids) == 0
//           ? ''
//           : int.parse(oddPercentage) >= 90
//               ? '90'
//               : int.parse(oddPercentage) <= 5
//                   ? '5'
//                   : '$oddPercentage';
//     } else {
//       return int.parse(totalBids) == 0
//           ? ''
//           : int.parse(oddPercentage) >= 90
//               ? 'Your Odds: Top 90%'
//               : int.parse(oddPercentage) <= 5
//                   ? 'Your Odds: Top 5%'
//                   : 'Your Odds: Top $oddPercentage%';
//     }
//   }
//
//   static String intToTimeLeft(int value) {
//     int h, m, s;
//
//     h = value ~/ 3600;
//
//     m = ((value - h * 3600)) ~/ 60;
//
//     s = value - (h * 3600) - (m * 60);
//     if (s < 0) {
//       s = 0;
//     }
//     String result =
//         "${h > 9 ? h : '0' + '$h'}:${m > 9 ? m : '0' + '$m'}:${s > 9 ? s : '0' + '$s'}";
// print("intToTimeLeft: ${result}");
//     return result;
//   }
//
//   static String getFormattedPrice(String price) {
//     var returnPrice = '\$ ' + double.parse(price).toStringAsFixed(2);
//
//     return returnPrice;
//   }
//
//   // static String getTimeDifference(String dateTime) {
//   //   print('date to convert $dateTime');
//   //   DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
//   //   Duration diff = DateTime.now().difference(input);
//   //   if (input.compareTo(DateTime.now()) == 0) {
//   //     return 'both dates are same';
//   //   } else if (input.compareTo(DateTime.now()) < 0) {
//   //     return '0';
//   //   } else {
//   //     return '${-(diff.inSeconds)}';
//   //     // return '${intToTimeLeft(diff.inSeconds).replaceAll('-', '')}';
//   //   }
//   //   print('input $input');
//   //   if (input.second < DateTime.now().second) {
//   //     return 'less';
//   //   } else {
//   //     return 'greater';
//   //   }
//   //   // return diff.inSeconds.toString();
//   //   if (diff.inMinutes <= 1) {
//   //     return diff.inMinutes.toString();
//   //   } else if (diff.inSeconds >= 1) {
//   //     return diff.inSeconds.toString();
//   //   } else {
//   //     return '0';
//   //   }
//   // }
//
//   static String convertToAgo(String dateTime) {
//     print('this is time ago $dateTime');
//     DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
//
//     tz.initializeTimeZone('data/latest_10y.tzf');
//     var detroit = tz.getLocation('America/Chicago');
//    // var now = tz.TZDateTime.now(detroit);
//     var now = tz.TZDateTime.from(currentNPTTime, detroit);
//     String nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     DateTime formateNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(nowDate);
//     Duration diff = formateNow.difference(input);
//    // Duration diff = currentNPTTime.difference(formateNow);
//     // Duration diff = DateTime.now().difference(input);
//     print('this is  input ${input}');
//     // print('this is  input differance ${diff}');
//
//     if (diff.inDays >= 1) {
//       return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
//     } else if (diff.inHours >= 1) {
//       return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
//     } else if (diff.inMinutes >= 1) {
//       return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
//     } else if (diff.inSeconds >= 1) {
//       return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
//     } else {
//       return 'just now';
//     }
//   }
//
//   static getTimeDifference(DateTime time) {
//     var currentTime = DateTime.now();
//
//     Duration diff = currentTime.difference(time);
//
//     return diff.inSeconds;
//   }
//   static getTimeZoneDate() async {
//     print(
//         '=========================getTimeZoneDate =========================');
//
//       try {
//         var response = await dio.Dio().get('http://worldtimeapi.org/api/timezone/America/Chicago');
//
//         var jsonData = jsonDecode(response.toString());
//         print('response from controller getTimeZoneDate $jsonData');
//         if (response != null) {
//           //timeZoneDate=TimeZoneDate.fromJson(jsonData);
//         } else {}
//       } catch (e) {
//
//         print(e.toString());
//       }
//
//   }
//
//  static DateTime currentNPTTime=DateTime.now();
//
//
// static getNPTTime()async{
// print("I am Called getNPTTime");
//   Timer.periodic(Duration(seconds: 1), (timer) async{
//
//     DateTime startDate = new DateTime.now().toLocal();
//
//     int offset = await NTP.getNtpOffset(localTime: startDate);
//     //print('NTP DateTime offset align: ${startDate.add(new Duration(milliseconds: offset))}');
//     currentNPTTime = await NTP.now();
//     String nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(currentNPTTime);
//     currentNPTTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(nowDate);
//    // print('NTP DateTime: ${currentNPTTime}');
//   });
//
//
// }
//   static int getTimeDifferenceInt(String dateTime) {
//
//
//     DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
//     tz.initializeTimeZone('data/latest_10y.tzf');
//    // tz.initializeTimeZone();
//     var detroit = tz.getLocation('America/Chicago');
//     tz.setLocalLocation(detroit);
//
//     //var now = tz.TZDateTime.now(detroit);
//     var now = tz.TZDateTime.from(currentNPTTime, detroit); //.now(currentNPTTime);
//     String nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     DateTime formateNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(nowDate);
//     // DateTime now = DateTime.now();
//
//
//     // print('input $input');
//     // print('input now2 $formateNow');
//     // print('input now ${tz.TZDateTime.now(detroit).timeZoneOffset}');
//     // print('input timeZoneName ${detroit.name}');
//
//     //  getTimeZoneDate();
//     //  if(timeZoneDate==null)
//     //    return 0;
//     // String nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(timeZoneDate!.datetime);
//     // DateTime formateNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(nowDate);
//     // print('input $input');
//     //   print('input now $formateNow');
//     Duration diff = input.difference(formateNow);
//    // Duration diff = input.difference(formateNow);
//     print('getTimeDifferenceInt: ${diff.inSeconds}');
//     if (diff.inSeconds == 0) {
//       return 0;
//     } else if (diff.inSeconds < 0) {
//       return -1;
//     } else {
//       return diff.inSeconds;
//     }
//   }
//
//
//
//   static String dobDateFormat = 'yyyy-MM-dd';
//
//   static bool isUnderAge(String dob) {
//     debugPrint('isUnderAge ------- $dob');
//
//     if (dob == '') {
//       return false;
//     }
//     print("-------i am here${dob}");
//     // DateTime input = DateFormat('dd-MM-yyyy').parseÏ(dob);
//     DateTime input = DateFormat(dobDateFormat).parse(dob);
//     print("-------dob:   ${input}");
//     var now = DateTime.now();
//     Duration diff = now.difference(input);
//     print("---------------age: " + (diff.inDays / 365).toString());
//     return (diff.inDays / 365) < 18;
//   }
//
//   static bool isUnderThirteen(String dob) {
//     debugPrint('isUnderAge ------- $dob');
//
//     if (dob == '') {
//       return false;
//     }
//     print("-------i am here${dob}");
//     // DateTime input = DateFormat('dd-MM-yyyy').parseÏ(dob);
//     DateTime input = DateFormat(dobDateFormat).parse(dob);
//     print("-------dob:   ${input}");
//     var now = DateTime.now();
//     Duration diff = now.difference(input);
//     print("---------------age: " + (diff.inDays / 365).toString());
//     return (diff.inDays / 365) < 13;
//   }
//
//   static bool isMobile() {
//     if (isWebPlatform()) {
//       return false;
//     } else if (isAndroidPlatform()) {
//       return true;
//     } else if (isIOSPlatform()) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   static bool isWebPlatform() {
//     return UniversalPlatform.isWeb;
//   }
//
//   static bool isAndroidPlatform() {
//     return UniversalPlatform.isAndroid;
//   }
//
//   static bool isFuchsiaPlatform() {
//     return UniversalPlatform.isFuchsia;
//   }
//
//   static bool isIOSPlatform() {
//     return UniversalPlatform.isIOS;
//   }
//
//   static String getTimesAgo(String dateTime) {
//     DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
//     Duration diff = DateTime.now().difference(input);
//
//     debugPrint('getTimesAgo ---- $dateTime');
//     debugPrint('getTimesAgo ---- ${diff.inDays}');
//     if (diff.inDays <= 7) {
//       return '${diff.inDays - 7} day${diff.inDays == 1 ? '' : 's'} to'
//           .replaceAll('-', '');
//     } else {
//       return '';
//     }
//
//     if (diff.inDays >= 1) {
//       return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} to';
//     } else if (diff.inHours >= 1) {
//       return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} to';
//     } else if (diff.inMinutes >= 1) {
//       return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} to';
//     } else if (diff.inSeconds >= 1) {
//       return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} to';
//     } else {
//       return '';
//     }
//   }
// }
//
// // - Setup Keys
//
// class Setup {
//   // static const bool isDebug = kDebugMode;
//
//   static var formKey = GlobalKey<FormState>();
//
//   static const bool isDebug = kDebugMode;
//
//   static String appName = Config.appName;
//   static String appVersion = Config.appVersion;
//   static final String dataBaseName = '/${Config.appName.replaceAll(" ", "")}';
// // static String bio = "welcome_bio".tr(namedArgs: {"app_name": appName});
// }
//
// // - Configurations Keys
// class Config {
//   static const String packageNameAndroid = "com.freebieclicks.app";
//   static const String packageNamIOS = "com.freebieclicks.app";
//   static const String iosAppStoreId = "1662988918";
//   static const String appName = "Freebie Clicks";
//   static const String appVersion = "1.0.1";
//   static const String companyName = "DigixValley";
//
//   // - AdMob App ids
//   static const String appIdAndroid = "ca-app-pub-5831678665801969~9708564557";
//   static const String appIdIOS = "ca-app-pub-5831678665801969~8516307358";
//
//   static String appIdLive =
//       QuickHelp.isAndroidPlatform() ? appIdAndroid : appIdIOS;
//
//   static String appIdTest = QuickHelp.isAndroidPlatform()
//       ? 'ca-app-pub-3940256099942544~3347511713'
//       : 'ca-app-pub-3940256099942544~1458002511';
//
//   static const String initialCountry = 'US'; // United States
//
//   static const String serverUrl = "";
//   static const String facebookAppId = "1279542542821787";
//   static const String agoraAppId = "ADD HERE";
//
//   // Languages
//   static String defaultLanguage = "en"; // English is default language.
//   static List<Locale> languages = [Locale(defaultLanguage), Locale('en')];
//
//   // Dynamic link
//   static const String inviteSuffix = "invitee";
//
//   // static const String kUriPrefix = 'https://freebieclicks.page.link';
//   static const String kUriPrefix = 'https://freebieclicks.page.link';
//
//   // static const String link = 'https://owner.foodageapp.com/';
//   // static const String link = 'https://digixvalley.foodageapp.com/';
//
//   static const String link = 'https://freebieclicks.page.link?ref=';
// }
