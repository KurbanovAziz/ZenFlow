import 'package:flutter/cupertino.dart';

import '../../Utils/app_imports/app_imports.dart';
import '../Fonts/AppFonts.dart';

Widget customListTileWidget(
    {String image = AppImages.logo,
    String title = 'Notification',
    String subTitle = 'Description',
    Color color = Colors.transparent,
    bool isSuffix = true,
    bool isSubTitle = true,
    bool isToggle = true,
    bool isPrefix = true,
    bool isPrefixIcon = false,
    double iconSize = 20,
    Widget prefix = const SizedBox(),
    Color iconColor = Colors.white,
    Color titleColor = Colors.white,
    Color subTitleColor = Colors.white,
    IconData icon = Icons.arrow_forward_ios_rounded,
    bool value = true}) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
      bottom: BorderSide(color: color),
    )),
    child: Row(
      children: [
        isPrefix
            ? isPrefixIcon
                ? prefix
                : Image.asset(
                    image,
                    height: Get.height * 0.03,
                    color: iconColor,
                  )
            : const SizedBox.shrink(),
        isPrefix ? hSizedBox() : const SizedBox.shrink(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
                text: title,
                size: AppDimensions.FONT_SIZE_16,
                color: titleColor,
                fontWeight: FontWeights.medium),
            isSubTitle
                ? SizedBox(
                    width: Get.width * 0.55,
                    child: AppText(
                        text: subTitle,
                        size: AppDimensions.FONT_SIZE_14,
                        color: subTitleColor,
                        fontWeight: FontWeights.regular),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        const Spacer(),
        isSuffix
            ? isToggle
                ? CupertinoSwitch(
                    activeColor: whitePrimary,
                    value: value,
                    onChanged: (bool value) {
                      value = value;
                    },
                  )
                : Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  )
            : const SizedBox.shrink()
      ],
    ),
  );
}

// customListTileWidget(
// icon: Icons.abc_outlined,
// isToggle: false,
// isSubTitle: false,
// isPrefix: true,
// isPrefixIcon: true,
// prefix: Icon(Icons.abc_outlined)
// )
