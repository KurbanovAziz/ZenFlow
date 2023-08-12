import 'package:fluttertoast/fluttertoast.dart';
import '../app_imports/app_imports.dart';

SnackbarController appSnackBar({
  required String tileText,
  required String descriptionText,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
  int duration = 2,
  Color textColor = Colors.white,
  Color backgroundColor = const Color(0xff2B3EA8),
}) {
  return Get.snackbar(
    tileText,
    descriptionText,
    snackPosition: snackPosition,
    duration: Duration(seconds: duration),
    colorText: textColor,
    backgroundColor: backgroundColor,
  );
}

appToastView({required String title}) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: darkPrimary,
      textColor: whiteOnPrimary,
      fontSize: 16.0);
}
