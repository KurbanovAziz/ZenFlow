import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

import '../Themes/AppTheme.dart';

customSnackBar({required String title}) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.PRIMARY_COLOR, // darkPrimary,
      textColor: whiteOnPrimary,
      fontSize: 16.0);
}

customLoading({Color? color}) {
  return Center(
      child: CircularProgressIndicator(
    color: color ?? darkPrimary,
  ));
}
