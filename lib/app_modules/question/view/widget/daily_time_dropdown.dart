import '../../../../utils/app_imports/app_imports.dart';

dailyTimeDropDown({required QuestionController questionController}) {
  return Container(
    padding: AppPaddings.horizontal,
    decoration: BoxDecoration(
      color: AppColors.BLACK.withOpacity(0.5),
      borderRadius: AppBorderRadius.BORDER_RADIUS_30,
    ),
    child: Obx(() => Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconEnabledColor: AppColors.WHITE_COLOR,
                dropdownColor: AppColors.BLACK.withOpacity(0.5),
                style: TextStyle(
                  color: AppColors.WHITE_COLOR,
                  fontSize: AppDimensions.FONT_SIZE_18,
                  fontWeight: FontWeight.w500,
                ),
                value: questionController.getDailyTimeTarget.isEmpty
                    ? null
                    : questionController.getDailyTimeTarget,
                onChanged: (String? newValue) {
                  questionController.setDailyTimeTarget = newValue!;
                },
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: AppText(
                        text: 'Select Daily Yoga Time',
                        color: AppColors.WHITE_COLOR,
                      ),
                    ),
                  ),
                  for (var index = 0;
                      index < questionController.dailyTimetargetList.length;
                      index++) ...{
                    DropdownMenuItem(
                      value: questionController.dailyTimetargetList[index],
                      child: Padding(
                        padding: const EdgeInsets.only(right: 190.0),
                        child: AppText(
                          text: questionController.dailyTimetargetList[index],
                          color: AppColors.WHITE_COLOR,
                        ),
                      ),
                    ),
                  }
                ],
              ),
            ),
          ],
        )),
  );
}
