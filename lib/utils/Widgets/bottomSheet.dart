// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Paddings/AppBorderRadius.dart';
import '../Themes/AppColors.dart';
import '../Themes/AppTheme.dart';

void showSheet(
  BuildContext context, {
  required Widget child,
  double? initialChildSize,
  double? maxChildSize,
}) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: whiteOnPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    // set this to true
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: initialChildSize ?? 0.3,
        maxChildSize: maxChildSize ?? 0.3,
        builder: (_, controller) {
          return child;
        },
      );
    },
  );
}

void bottomSheet({Widget child = const SizedBox()}) {
  Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: blackOnPrimary.withOpacity(.7),
            borderRadius: AppBorderRadius.BORDER_RADIUS_12),
        child: child
      ),
      isScrollControlled: true);
}
