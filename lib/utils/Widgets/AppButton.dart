// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import '../../Utils/app_imports/app_imports.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final FontWeight fontWeight;
  final BorderRadius buttonRadius;
  final IconData icon;
  final String iconImage;
  final bool isIcon;
  final bool isCenter;
  final double iconSize;
  final double iconWidth;
  final double iconHight;
  final double paddingButton;
  final VoidCallback onTap;
  final double borderWidth;
  final Color borderColor;
  final String fontFamily;
  bool isSuffix = false;
  double elevation = 3.0;

  AppButton({
    Key? key,
    required this.buttonName,
    this.buttonWidth = 250,
    this.buttonHeight = 50,
    required this.buttonColor,
    required this.textColor,
    this.fontWeight = FontWeight.w600,
    this.buttonRadius = BorderRadius.zero,
    this.iconColor = Colors.white,
    this.icon = Icons.home,
    this.iconImage = "",
    this.isIcon = false,
    this.isCenter = false,
    this.iconSize = 25,
    this.iconWidth = 21,
    this.iconHight = 14,
    this.paddingButton = 0,
    this.fontFamily = "Nunito",
    required this.onTap,
    this.textSize = 16,
    this.borderWidth = 1,
    this.elevation = 3.0,
    this.isSuffix = false,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*GetPlatform.isAndroid
        ? Container(
            height: buttonHeight,
            width: buttonWidth,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                surfaceTintColor: buttonColor,
                textStyle: TextStyle(
                    color: textColor,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight,
                    fontSize: textSize),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      AppBorderRadius.BORDER_RADIUS_10 ?? buttonRadius,
                ),
                elevation: elevation,
              ),
              onPressed: onTap,
              child: Padding(
                padding: isCenter
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                child: Row(
                  mainAxisAlignment: paddingButton == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !isSuffix
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    //color: iconColor,
                                    size: iconSize,
                                  )
                                : SvgPicture.asset(
                                    iconImage,
                                    //color: iconColor,
                                    height: iconSize,
                                  )
                            : Container()
                        : Container(),
                    isCenter
                        ? const Spacer()
                        : SizedBox(
                            width: paddingButton == 0
                                ? isIcon
                                    ? 10
                                    : 0
                                : paddingButton,
                          ),
                    isSuffix
                        ? SizedBox(
                            width: Get.width * 0.6,
                            child: Center(
                              child: AppText(
                                  text: buttonName,
                                  color: textColor,
                                  fontFamily: fontFamily,
                                  fontWeight: fontWeight,
                                  size: textSize),
                            ),
                          )
                        : Center(
                            child: AppText(
                                text: buttonName,
                                color: textColor,
                                fontFamily: fontFamily,
                                fontWeight: fontWeight,
                                size: textSize),
                          ),
                    isCenter ? const Spacer() : Container(),
                    isCenter
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : SvgPicture.asset(
                                    iconImage,
                                    //color: iconColor,
                                    height: iconSize,
                                  )
                            : Container()
                        : Container(),
                    isSuffix
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : Row(
                                    children: [
                                      SvgPicture.asset(
                                        iconImage,
                                        //color: iconColor,
                                        height: iconSize,
                                      )
                                    ],
                                  )
                            : Container()
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        : */
        Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
                color: buttonColor,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 4,
                      color: AppColors.GRAY.withOpacity(0.1))
                ],
                borderRadius: AppBorderRadius.BORDER_RADIUS_05 ?? buttonRadius,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                )),
            child: CupertinoButton(
              borderRadius: AppBorderRadius.BORDER_RADIUS_05 ?? buttonRadius,
              padding: EdgeInsets.zero,
              color: buttonColor,
              onPressed: onTap,
              child: Padding(
                padding: isCenter
                    ? const EdgeInsets.symmetric(horizontal: 16)
                    : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                child: Row(
                  mainAxisAlignment: paddingButton == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !isSuffix
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : iconImage.contains('svg')
                                    ? SvgPicture.asset(
                                        iconImage,
                                        //color: iconColor,
                                        height: iconSize,
                                      )
                                    : Image.asset(
                                        iconImage,
                                        height: 25,
                                        width: 25,
                                      )
                            : Container()
                        : Container(),
                    isCenter
                        ? const Spacer()
                        : SizedBox(
                            width: paddingButton == 0
                                ? isIcon
                                    ? 10
                                    : 0
                                : paddingButton,
                          ),
                    isSuffix
                        ? SizedBox(
                            width: Get.width * 0.6,
                            child: Center(
                              child: AppText(
                                  text: buttonName,
                                  color: textColor,
                                  fontFamily: fontFamily,
                                  fontWeight: fontWeight,
                                  size: textSize),
                            ),
                          )
                        : Center(
                            child: AppText(
                                text: buttonName,
                                color: textColor,
                                fontFamily: fontFamily,
                                fontWeight: fontWeight,
                                size: textSize),
                          ),
                    isCenter ? const Spacer() : Container(),
                    // !isCenter
                    //     ? isIcon
                    //         ? iconImage == ""
                    //             ? Icon(
                    //                 icon,
                    //                 color: iconColor,
                    //                 size: iconSize,
                    //               )
                    //             : SvgPicture.asset(
                    //                 iconImage,
                    //                 //color: iconColor,
                    //                 height: iconSize,
                    //               )
                    //         : Container()
                    //     : Container(),
                    // isSuffix
                    //     ? isIcon
                    //         ? iconImage == ""
                    //             ? Icon(
                    //                 icon,
                    //                 color: iconColor,
                    //                 size: iconSize,
                    //               )
                    //             : Row(
                    //                 children: [
                    //                   SvgPicture.asset(
                    //                     iconImage,
                    //                     //color: iconColor,
                    //                     height: iconSize,
                    //                   )
                    //                 ],
                    //               )
                    //         : Container()
                    //     : Container(),
                  ],
                ),
              ),
            ));
  }
}
