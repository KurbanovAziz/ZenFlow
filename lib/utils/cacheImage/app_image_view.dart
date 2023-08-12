import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zen_flow/utils/loader/app_loader.dart';

import '../../Utils/app_imports/app_imports.dart';
import '../helper_functions.dart';

class AppImageView extends StatelessWidget {
  // final searchRestCard widget;
  // final GoogleRestaurantController controller;
  final String imageUrl;
  var height = Get.height / 13;
  var width = Get.width / 4.7;

  AppImageView({
    Key? key,
    required this.imageUrl,
    this.height = 40,
    this.width = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.BORDER_RADIUS_10,
      child: Image.network(
        imageUrl,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          print(exception);
          return SvgPicture.asset(
            AppImages.logo,
            width: width,
            fit: BoxFit.cover,
            height: height,
          );
        },
        width: width,
        fit: BoxFit.cover,
        height: height,
      ),
    );
  }
}

class AppCacheImageView extends StatelessWidget {
  AppCacheImageView(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.borderRadius = 10,
      this.isProfile = false})
      : super(key: key);

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;
  bool isProfile = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        // height: AppConfig(context).height * .04,
        //  height: height,

        width: width,
        fit: isProfile ? BoxFit.cover : BoxFit.contain,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        // imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            // width: 25,
            // height: 15,
            margin: const EdgeInsets.all(2),
            child: customLoader(
              darkPrimary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => SvgPicture.asset(
          AppImages.logo,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

class AppProfileCacheImageView extends StatelessWidget {
  AppProfileCacheImageView({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 100,
  }) : super(key: key);

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        // height: AppConfig(context).height * .04,
        height: height,

        width: width,
        fit: BoxFit.cover,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        // imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            // width: 25,
            // height: 15,
            margin: const EdgeInsets.all(2),
            child: customLoader(
              darkPrimary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => SvgPicture.asset(
          AppImages.logo,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

Widget customImage(
    {required String imageUrl,
    bool isProfile = true,
    double radius = 10,
    var width = 50.0,
    var height = 70.0,
    Color? color,
    Color? borderColor,
    BoxFit fit = BoxFit.cover}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      // border: Border.all(color: borderColor ?? AppColors.WHITE_COLOR, width: 2),
      //  color: color ?? AppColors.BOTTOM_NAV_BACKGROUND,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(
            imageUrl,
          ),
          errorBuilder: (context, error, stackTrace) {
            return customLoader(darkPrimary);
          },
          // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          //   return Image.asset(AppImages.placeHolder);
          // },
          fit: BoxFit.cover,
        )),
  );
}
