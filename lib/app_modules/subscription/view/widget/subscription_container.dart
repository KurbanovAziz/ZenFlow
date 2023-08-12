import 'package:zen_flow/utils/app_imports/app_imports.dart';

subcriptionContainer({
  required String title,
  required String subPrice,
  required String perSub,
  required String subDetail,
  Color borderColor = Colors.transparent,
  required VoidCallback ontap,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: Get.height * .23,
      decoration: BoxDecoration(
          color: AppColors.BLACK.withOpacity(0.3),
          borderRadius: AppBorderRadius.BORDER_RADIUS_15,
          border: Border.all(color: borderColor)),
      padding: AppPaddings.defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            color: AppColors.WHITE_COLOR,
            fontWeight: FontWeight.w600,
          ),
          vSizedBox(height: 10),
          AppText(
              text: subPrice,
              color: AppColors.PRIMARY_COLOR,
              fontWeight: FontWeight.w600,
              size: AppDimensions.FONT_SIZE_18),
          AppText(
            text: perSub,
            color: AppColors.PRIMARY_COLOR,
            // fontWeight: FontWeight.w600,
          ),
          vSizedBox(height: 05),
          AppText(
              text: subDetail,
              color: AppColors.WHITE_COLOR,
              // fontWeight: FontWeight.w500,
              size: AppDimensions.FONT_SIZE_12),
        ],
      ),
    ),
  );
}
