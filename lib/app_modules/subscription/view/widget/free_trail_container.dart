import 'package:zen_flow/utils/app_imports/app_imports.dart';

freeTrailContainer({
  String title = '',
  String subtitle = '',
  String subDetail = '',
  Color borderColor = Colors.transparent,
  required VoidCallback ontap,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      // height: Get.height * .23,
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
          subtitle.isEmpty ? const SizedBox.shrink() : vSizedBox(height: 10),
          subtitle.isEmpty
              ? const SizedBox.shrink()
              : AppText(
                  text: subtitle,
                  color: AppColors.WHITE_COLOR,
                  fontWeight: FontWeight.w500,
                  // size: AppDimensions.FONT_SIZE_18,
                ),
          subDetail.isEmpty ? const SizedBox.shrink() : vSizedBox(height: 05),
          subDetail.isEmpty
              ? const SizedBox.shrink()
              : AppText(
                  text: subDetail,
                  color: AppColors.WHITE_COLOR,
                  // fontWeight: FontWeight.w500,
                  size: AppDimensions.FONT_SIZE_12),
        ],
      ),
    ),
  );
}
