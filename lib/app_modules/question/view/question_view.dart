import 'package:zen_flow/utils/Widgets/customSnakbar.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class QuestionView extends StatelessWidget {
  QuestionView({super.key});

  QuestionController questionController = Get.put(QuestionController());

  // TextEditingController genderController = TextEditingController();
  // TextEditingController fitnessLevelController = TextEditingController();
  // TextEditingController goalController = TextEditingController();
  // TextEditingController tragetTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.questionImageNetwork,
        child: Obx(
          () => Column(
            children: [
              PrimaryAppBar(
                titleText: 'generalQuestions'.tr,
                appbarColor: AppColors.TRANSPARENT_COLOR,
                titleColor: AppColors.WHITE_COLOR,
                isSuffix: false,
                prefixButtonColor: AppColors.TRANSPARENT_COLOR,
                prefixOnTap: () {
                  questionController.getQuestion == 0
                      ? null
                      : questionController.setQuestion =
                          questionController.getQuestion - 1;
                },
              ),
              Expanded(
                child: Padding(
                  padding: AppPaddings.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vSizedBox(height: Get.height * 0.02),
                      for (var index = 0;
                          index <= questionController.questions.length;
                          index++) ...{
                        questionController.getQuestion == index
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                      text: questionController.questions[index],
                                      color: AppColors.WHITE_COLOR,
                                      fontWeight: FontWeight.bold,
                                      size: AppDimensions.FONT_SIZE_22),
                                  vSizedBox(height: Get.height * 0.025),
                                  index == 0
                                      ? AppTextField(
                                          controller:
                                              questionController.ageController,
                                          keyboardType: TextInputType.number,
                                          hint: questionController
                                              .questionsHints[index],
                                        )
                                      : index == 1
                                          ? genderDropDown(
                                              questionController:
                                                  questionController)
                                          : index == 2
                                              ? fitnessLevelDropDown(
                                                  questionController:
                                                      questionController)
                                              : index == 3
                                                  ? weightLossGoalDropDown(
                                                      questionController:
                                                          questionController)
                                                  : dailyTimeDropDown(
                                                      questionController:
                                                          questionController)
                                ],
                              )
                            : const SizedBox.shrink(),
                      },
                      Spacer(),
                      AppButton(
                          buttonWidth: Get.width,
                          buttonName: questionController.getQuestion == 4
                              ? 'save&Continue'.tr
                              : 'next'.tr,
                          buttonColor: AppColors.PRIMARY_COLOR,
                          textColor: AppColors.WHITE_COLOR,
                          onTap: () {
                            Get.arguments != null
                                ? questionController.moveToNextquestion(
                                    subscriptionType:
                                        Get.arguments['subscriptionType'],
                                    loginType: Get.arguments['loginType'])
                                : null;
                          }),
                      vSizedBox(height: Get.height * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
