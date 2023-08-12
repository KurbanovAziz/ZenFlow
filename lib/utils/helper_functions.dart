// ignore_for_file: avoid_print, prefer_adjacent_string_concatenation

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/app_imports/app_imports.dart';

const int imageQualityCompress = 50;

class HelperFunctions {
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String getImageUrl(String image) {
    return '${ApiConstant.imageBaseUrl}$image';
  }

  static launchUrl(String url) async {
    await launch(url);
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  String checkDate(DateTime scheduleDate) {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);
    final scheduleDateOnly =
        DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day);

    if (scheduleDateOnly.isBefore(currentDate)) {
      return "Past";
    } else if (scheduleDateOnly.isAfter(currentDate)) {
      return "Future";
    } else {
      return "Current";
    }
  }

  String getMonthName(String monthNumber) {
    switch (monthNumber) {
      case '01':
        return 'Jan';
      case '02':
        return 'Feb';
      case '03':
        return 'Mar';
      case '04':
        return 'Apr';
      case '05':
        return 'May';
      case '06':
        return 'Jun';
      case '07':
        return 'Jul';
      case '08':
        return 'Aug';
      case '09':
        return 'Sep';
      case '10':
        return 'Oct';
      case '11':
        return 'Nov';
      case '12':
        return 'Dec';
      default:
        return '';
    }
  }

  Color returnStatus(var snapshot) {
    Color? color;
    if (HelperFunctions()
            .checkDate(DateTime.parse(snapshot['schedule_date'])) ==
        'Past') {
      if (snapshot['workout_status'] ==
          ScheduleStatus.pending.name.toString()) {
        color = AppColors.GRAY;
      } else if (snapshot['workout_status'] ==
          ScheduleStatus.failed.name.toString()) {
        color = AppColors.RED_COLOR;
      } else {
        color = AppColors.Mint_Green;
      }
      // return color;
    } else if (HelperFunctions()
            .checkDate(DateTime.parse(snapshot['schedule_date'])) ==
        'Future') {
      if (snapshot['workout_status'] ==
          ScheduleStatus.pending.name.toString()) {
        color = AppColors.GRAY;
      } else if (snapshot['workout_status'] ==
          ScheduleStatus.failed.name.toString()) {
        color = AppColors.RED_COLOR;
      } else {
        color = AppColors.Mint_Green;
      }
      // re
    } else {
      if (snapshot['workout_status'] ==
          ScheduleStatus.pending.name.toString()) {
        color = AppColors.GRAY;
      } else if (snapshot['workout_status'] ==
          ScheduleStatus.failed.name.toString()) {
        color = AppColors.RED_COLOR;
      } else {
        color = AppColors.Mint_Green;
      }
    }

    return color;
  }

//////////////////////////////////////////////////////

  static String convertToAgo(String dateTime) {
    DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  static void foo() {
    print("1234");
  }

  static Future<String> phoneNumberFormatter(String phoneNumber) async {
    String newText = '';
    // if (newText.length == 2) newText = "(" + newText;
    // if (newText.length == 4) newText = newText + ") ";
    // if (newText.length == 9) newText = newText + " ";

    newText = phoneNumber.replaceAllMapped(
        RegExp(r'(\d{1})(\d{3})(\d{3})(\d+)'),
        (Match m) => "${m[1]} (${m[2]}) ${m[3]}-${m[4]}");

    print('phoneNumberFormatter : ${newText}');
    print('$phoneNumberFormatter'.replaceAllMapped(
        RegExp(r'(\d{1})(\d{3})(\d{3})(\d+)'),
        (Match m) => "${m[1]} (${m[2]}) ${m[3]}-${m[4]}"));

    return newText;
  }

  static convertDateTime(
      {String dateString = '31/12/2000 23:59',
      String convertIn = 'EEEE, dd, MMM'}) {
    // var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var inputFormat = DateFormat('MM/dd/yyyy');
    var inputDate = inputFormat.parse(dateString); // <-- dd/MM 24H format

    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputFormat = DateFormat(convertIn);
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);

    return outputDate;
  }

  static String getTimesAgo(String dateTime) {
    DateTime input = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
    Duration diff = DateTime.now().difference(input);

    debugPrint('getTimesAgo ---- $dateTime');
    debugPrint('getTimesAgo ---- ${diff.inDays}');
    if (diff.inDays <= 7) {
      return '${diff.inDays - 7} day${diff.inDays == 1 ? '' : 's'} to'
          .replaceAll('-', '');
    } else {
      return '';
    }
  }

  static String timeAgoSinceDate(
    String dateString,
  ) {
    DateTime notificationDate =
        DateFormat("yyyy-MM-dd h:mm:ss").parse(dateString);
    // DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if ((difference.inDays / 7).floor() >= 1 &&
        (difference.inDays / 7).floor() < 2) {
      return '1 week ago';
    } else if ((difference.inDays / 7).floor() >= 2 &&
        (difference.inDays / 7).floor() < 3) {
      return '2 weeks ago';
    } else if ((difference.inDays / 7).floor() >= 3 &&
        (difference.inDays / 7).floor() < 4) {
      return '3 weeks ago';
    } else if ((difference.inDays / 7).floor() >= 4) {
      return 'A month ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return '1 hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return '1 minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String result =
        "${h > 9 ? h : '0' + '$h'}:${m > 9 ? m : '0' + '$m'}:${s > 9 ? s : '0' + '$s'}";

    return result;
  }

  static String getFormattedPrice(String price) {
    var returnPrice = '\$ ' + double.parse(price).toStringAsFixed(2);

    return returnPrice;
  }
}

/// - Configurations Keys
class Config {
  static const String packageNameAndroid = "com.exapmle.app";
  static const String packageNamIOS = "com.example.app";
  static const String iosAppStoreId = "1662988918";
  static const String appName = "Zen Flow";
  static const String appVersion = "1.0.0";
  static const String companyName = "DigixValley";
  static const String appleId = "DigixValley";

  // - AdMob App ids
  static const String appIdAndroid = "appIdAndroid";
  static const String appIdIOS = "appIdIOS";

  static String appIdLive = GetPlatform.isAndroid ? appIdAndroid : appIdIOS;

  static String appIdTest = GetPlatform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-3940256099942544~1458002511';

  static const String initialCountry = 'US'; // United States

  static const String serverUrl = "";
  static const String facebookAppId = "1279542542821787";
  static const String agoraAppId = "ADD HERE";

  // Languages
  static String defaultLanguage = "en"; // English is default language.
  // static List<Locale> languages = [Locale(defaultLanguage), Locale('en')];

  // Dynamic link
  static const String inviteSuffix = "invitee";

  static const String kUriPrefix = 'https://freebieclicks.page.link';

  static const String link = 'https://freebieclicks.page.link?ref=';

  static const int minimumAgeToRegister = 16;
  static bool minimumAgeAllowed(String birthDateString, String datePattern) {
    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate =
        DateFormat(datePattern, "en_US").parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + minimumAgeToRegister,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(today);
  }

  static String dateFormatDmy = "dd/MM/yyyy";

// How to use
  // HelperFunctions.minimumAgeAllowed(value, HelperFunctions.dateFormatDmy)
}
