import 'package:zen_flow/app_modules/result/controller/dynamicLink_controller.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  int totalYogaMinutes =
      0; // Replace 100 with your desired total number of minutes
  int yogaHours = 0;
  int yogaMinutes = 0;
  int yogaSeconds = 0;
  DynamicController dynamicController = Get.put(DynamicController());

  @override
  void initState() {
    totalYogaMinutes = Get.arguments['yogaStatus'] == true
        ? int.parse(Get.arguments['WarkoutTime'])
        : 0;
    Get.arguments['yogaStatus'] == true ? totalTime() : null;
    super.initState();
  }

  void totalTime() {
    yogaHours = totalYogaMinutes ~/ 60;
    int remainingMinutes = totalYogaMinutes % 60;
    yogaMinutes = remainingMinutes;
    yogaSeconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    print('valuess ${Get.arguments}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: BGDarkCoverImage(
            image: Get.arguments['yogaStatus'] == true
                ? AppImages.workOutCompleteNetwork
                : AppImages.failWorkOutNetwork,
            colors: Get.arguments['yogaStatus'] == true
                ? AppColors.Green.withOpacity(0.7)
                : AppColors.PRIMARY_COLOR_OPACITY.withOpacity(.6),
            child: Padding(
              padding: AppPaddings.horizontal,
              child: Column(
                children: [
                  vSizedBox(height: Get.height * 0.1),
                  Expanded(
                    // flex: 2,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Get.arguments['yogaStatus'] == true
                              ? AppImages.completeWorkOutSvg
                              : AppImages.failWorkOutSvg,
                          height: 150,
                          width: 150,
                        ),
                        vSizedBox(),
                        AppText(
                          text: Get.arguments['yogaStatus'] == true
                              ? 'congratulation'.tr
                              : 'trainingFailed'.tr,
                          size: AppDimensions.FONT_SIZE_30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.WHITE_COLOR,
                        ),
                        vSizedBox(height: 10),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: AppText(
                              text: Get.arguments['yogaStatus'] == true
                                  ? '${'you-burned'.tr} 198 ${'calories'.tr}'
                                  : 'failedDiscription'.tr,
                              // size: AppDimensions.FONT_SIZE_30,
                              // fontWeight: FontWeight.bold,
                              color: AppColors.WHITE_COLOR,
                              textAlign: TextAlign.center),
                        ),
                        vSizedBox(height: 10),
                        Container(
                          width: Get.width,
                          padding: AppPaddings.defaultPadding,
                          decoration: BoxDecoration(
                            color: AppColors.WHITE_COLOR.withOpacity(0.3),
                            borderRadius: AppBorderRadius.BORDER_RADIUS_15,
                          ),
                          child: Column(children: [
                            AppText(
                              text: 'totalWorkoutTime'.tr,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE_COLOR,
                            ),
                            AppText(
                              text: Get.arguments['yogaStatus'] == false
                                  ? Get.arguments['WarkoutTime']
                                  : '$yogaHours:${yogaMinutes.toString().padLeft(2, '0')}:${yogaSeconds.toString().padLeft(2, '0')}',
                              size: AppDimensions.FONT_SIZE_30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BLACK,
                            ),
                            AppText(
                              text: 'caloriesBurned'.tr,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE_COLOR,
                            ),
                            AppText(
                              text: '198',
                              size: AppDimensions.FONT_SIZE_30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BLACK,
                            ),
                            Get.arguments['yogaStatus'] == true
                                ? InkWell(
                                    onTap: () {
                                      dynamicController.buildDynamicLinks(
                                          "", '', '', '');
                                    },
                                    child: Container(
                                      padding: AppPaddings.defaultPadding,
                                      child: Icon(
                                        Icons.ios_share,
                                        color: AppColors.BLACK,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ]),
                        ),
                        vSizedBox(height: 20)
                      ],
                    ),
                  ),
                  AppButton(
                      buttonWidth: Get.width,
                      buttonName: Get.arguments['yogaStatus'] == true
                          ? 'planNextYoga'.tr
                          : 'continueToHome'.tr,
                      buttonColor: AppColors.PRIMARY_COLOR,
                      textColor: AppColors.WHITE_COLOR,
                      onTap: Get.arguments == true
                          ? () {
                              Get.toNamed(Routes.calenderScreen);
                            }
                          : () {
                              Get.toNamed(Routes.homeView);
                            }),
                  vSizedBox(),
                  Get.arguments['yogaStatus'] == true
                      ? AppButton(
                          buttonWidth: Get.width,
                          buttonName: 'continueToHome'.tr,
                          buttonColor: AppColors.TRANSPARENT_COLOR,
                          textColor: AppColors.WHITE_COLOR,
                          onTap: () {
                            Get.toNamed(Routes.homeView);
                          })
                      : const SizedBox.shrink(),
                  vSizedBox()
                ],
              ),
            )),
      ),
    );
  }
}
