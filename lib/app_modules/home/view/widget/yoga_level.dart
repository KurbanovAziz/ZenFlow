import '../../../../utils/app_imports/app_imports.dart';

yogaLevelContainer({
  required String title,
  required HomeController? homeController,
}) {
  return InkWell(
    onTap: () {
      Get.bottomSheet(
        yogaLevelbottomSheet(homeController: homeController),
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
                    text: homeController!.getIntensityLevel.isEmpty
                        ? 'selectintensity'.tr
                        : homeController.getIntensityLevel.toString(),
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

yogaLevelbottomSheet({HomeController? homeController}) {
  return Container(
    height: Get.height * 0.4,
    padding: AppPaddings.defaultPadding,
    decoration: BoxDecoration(
      color: AppColors.BLACK.withOpacity(0.9),
    ),
    child: Column(
      children: [
        AppText(
          text: 'intensityLevel'.tr,
          color: AppColors.WHITE_COLOR,
          size: AppDimensions.FONT_SIZE_16,
          fontWeight: FontWeight.w600,
        ),
        vSizedBox(height: 10),
        AppText(
            text: 'yourExperience'.tr,
            color: AppColors.WHITE_COLOR,
            size: AppDimensions.FONT_SIZE_14,
            textAlign: TextAlign.center),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                vSizedBox(height: 10),
                for (var index = 0;
                    index < homeController!.intensityList.length;
                    index++) ...{
                  GestureDetector(
                    onTap: () {
                      homeController.setIntensityLevel =
                          homeController.intensityList[index].toString();
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                          color: homeController.getIntensityLevel ==
                                  homeController.intensityList[index].toString()
                              ? AppColors.PRIMARY_COLOR.withOpacity(0.2)
                              : AppColors.WHITE_COLOR.withOpacity(0.2),
                        ),
                        padding: AppPaddings.defaultPadding,
                        child: Center(
                          child: AppText(
                            text:
                                homeController.intensityList[index].toString(),
                            color: homeController.getIntensityLevel ==
                                    homeController.intensityList[index]
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
        ),
      ],
    ),
  );
}
