import 'dart:ui';

import '../../Utils/app_imports/app_imports.dart';
import '../Fonts/AppFonts.dart';

class ReceiptActivityWidget extends StatelessWidget {
  String postThumbnail; // thumbnail image
  String descriptionText; // descriptionText text
  bool isBlur; // blur the image
  bool isVideo; // video condition
  VoidCallback? onTap; // widget onTap

  ReceiptActivityWidget(
      {Key? key,
      this.postThumbnail = '',
      this.isBlur = false,
      this.isVideo = false,
      this.descriptionText = '',
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: Get.height * 0.12,
                  width: Get.height * 0.12,
                  child: BlurredImageWidget(
                    imageUrl: postThumbnail,
                    isBlurred: isBlur, // or false
                  )),
              isVideo
                  ? Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.WHITE_COLOR.withOpacity(.5),
                          borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8),
                          child: Image.asset(
                            AppImages.logo,
                            height: Get.height * 0.015,
                          ),
                        ),
                      ))
                  : const SizedBox.shrink()
            ],
          ),
          hSizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: Get.width / 2,
                    child: AppText(
                        text: descriptionText,
                        color: AppColors.WHITE_COLOR,
                        size: AppDimensions.FONT_SIZE_16)),
                vSizedBox(),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.WHITE_COLOR,
                      child: Icon(
                        Icons.receipt_rounded,
                        color: AppColors.BLACK,
                      ),
                    ),
                    hSizedBox(width: Get.width * 0.015),
                    AppText(
                        text: 'Receipt',
                        color: AppColors.WHITE_COLOR,
                        fontWeight: FontWeights.medium,
                        size: AppDimensions.FONT_SIZE_18),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.WHITE_COLOR,
            ),
          )
        ],
      ),
    );
  }
}

class BlurredImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isBlurred;

  BlurredImageWidget({required this.imageUrl, this.isBlurred = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppBorderRadius.BORDER_RADIUS_10,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        if (isBlurred)
          ClipRRect(
            borderRadius: AppBorderRadius.BORDER_RADIUS_10,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
      ],
    );
  }
}
