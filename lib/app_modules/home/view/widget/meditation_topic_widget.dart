import '../../../../utils/app_imports/app_imports.dart';
import 'dart:developer' as dev;

yogaStyleContainer({
  required String title,
  required HomeController? homeController,
}) {
  return InkWell(
    onTap: () {
      Get.bottomSheet(
        yogaStylebottomSheet(homeController: homeController),
        isScrollControlled: true,
      );
    },
    child: Container(
      height: Get.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.BORDER_RADIUS_15,
        color: AppColors.WHITE_COLOR.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppText(
          text: title,
          color: AppColors.WHITE_COLOR,
          fontWeight: FontWeight.bold,
          size: AppDimensions.FONT_SIZE_16,
        ),
        vSizedBox(height: 05),
        Obx(() => Row(
              children: [
                Container(
                  width: Get.width * 0.3,
                  child: AppText(
                    text: homeController!.getYogaStyle.isEmpty
                        ? 'yogatype'.tr
                        : homeController.getYogaStyle.toString(),
                    color: AppColors.WHITE_COLOR,
                    size: AppDimensions.FONT_SIZE_14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ))
      ]),
    ),
  );
}

yogaStylebottomSheet({HomeController? homeController}) {
  return Container(
    height: Get.height * 0.7,
    padding: AppPaddings.defaultPadding,
    decoration: BoxDecoration(
      color: AppColors.BLACK.withOpacity(0.9),
    ),
    child: Column(
      children: [
        AppText(
          text: 'yogaStyle'.tr,
          color: AppColors.WHITE_COLOR,
          size: AppDimensions.FONT_SIZE_16,
          fontWeight: FontWeight.w600,
        ),
        vSizedBox(height: 10),
        AppText(
            text: 'practiceMethod'.tr,
            color: AppColors.WHITE_COLOR,
            size: AppDimensions.FONT_SIZE_14,
            textAlign: TextAlign.center),
        vSizedBox(height: 10),
        Obx(() => Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < homeController!.yogaSubCollections.length;
                        index++) ...{
                      GestureDetector(
                        onTap: () {
                          if (homeController.getIntensityLevel == '') {
                            customSnackBar(title: "pleaseSelectIntensity".tr);
                          } else {
                            homeController.setYogaStyle = homeController
                                .yogaSubCollections[index]
                                .toString();

                            homeController.fetchYogaVideoDocs(
                              yogaType: homeController.getYogaStyle,
                              intensitylevel: homeController.getIntensityLevel,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                              color: homeController.getYogaStyle ==
                                      homeController.yogaSubCollections[index]
                                          .toString()
                                  ? AppColors.PRIMARY_COLOR.withOpacity(0.2)
                                  : AppColors.WHITE_COLOR.withOpacity(0.2),
                            ),
                            padding: AppPaddings.defaultPadding,
                            child: Center(
                              child: AppText(
                                text: homeController.yogaSubCollections[index]
                                    .toString(),
                                color: homeController.getYogaStyle ==
                                        homeController.yogaSubCollections[index]
                                            .toString()
                                    ? AppColors.PRIMARY_COLOR
                                    : AppColors.WHITE_COLOR,
                              ),
                            ),
                          ),
                        ),
                      )
                    }
                  ],
                ),
              ),
            )),
      ],
    ),
  );
}
