import '../../../../utils/app_imports/app_imports.dart';

fitnessLevelDropDown({required QuestionController questionController}) {
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
                value: questionController.getFitnesslevel.isEmpty
                    ? null
                    : questionController.getFitnesslevel,
                onChanged: (String? newValue) {
                  questionController.setFitnesslevel = newValue!;
                },
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 150.0),
                      child: AppText(
                        text: 'Your Fitness Level',
                        color: AppColors.WHITE_COLOR,
                      ),
                    ),
                  ),
                  for (var index = 0;
                      index < questionController.fitnessList.length;
                      index++) ...{
                    DropdownMenuItem(
                      value: questionController.fitnessList[index],
                      child: Padding(
                        padding: const EdgeInsets.only(right: 200.0),
                        child: AppText(
                          text: questionController.fitnessList[index],
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
