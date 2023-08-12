import 'package:zen_flow/utils/app_imports/app_imports.dart';

dateTiles({
  Calendercontroller? calendercontroller,
  var snapshot,
  var scheduleDate,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppDimensions.FONT_SIZE_10),
    child: Row(
      children: [
        Container(
          height: Get.height * 0.1,
          width: Get.width * 0.015,
          decoration: BoxDecoration(
              color: HelperFunctions().returnStatus(snapshot),
              borderRadius: AppBorderRadius.BORDER_RADIUS_30),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 08),
          child: AppText(
            text:
                '${snapshot['schedule_date'].toString().split('-')[2].toString().split(' ').first}\n${HelperFunctions().getMonthName(snapshot['schedule_date'].toString().split('-')[1])}',
            size: AppDimensions.FONT_SIZE_24,
            color: AppColors.WHITE_COLOR,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: Get.height * 0.1,
            width: Get.width * 0.008,
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.BORDER_RADIUS_30,
              color: AppColors.WHITE_COLOR,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.6,
              child: AppText(
                text: "${snapshot['yoga_type']} Meditation Session",
                size: AppDimensions.FONT_SIZE_16,
                color: AppColors.WHITE_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppText(
              text: '${snapshot['workout_time']} mins',
              size: AppDimensions.FONT_SIZE_16,
              color: AppColors.GRAY,
              fontWeight: FontWeight.w400,
            ),
            AppText(
              text: '${snapshot['workout_status']}',
              size: AppDimensions.FONT_SIZE_16,
              color: snapshot['workout_status'] == ScheduleStatus.pending.name
                  ? AppColors.GRAY
                  : snapshot['workout_status'] == ScheduleStatus.failed.name
                      ? AppColors.RED_COLOR
                      : AppColors.Mint_Green,
              fontWeight: FontWeight.w600,
            )
          ],
        )
      ],
    ),
  );
}
