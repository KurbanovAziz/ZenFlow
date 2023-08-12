import 'package:zen_flow/app_modules/home/view/widget/yoga_level.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class ScheduleWWorkOut extends StatefulWidget {
  ScheduleWWorkOut({super.key});

  @override
  State<ScheduleWWorkOut> createState() => _ScheduleWWorkOutState();
}

// String selectedValue = 'Love';
double containerHeight = 0.4; // Initial height

class _ScheduleWWorkOutState extends State<ScheduleWWorkOut> {
  HomeController homeController = Get.find();
  SocialAuthController socialAuthController = Get.find();
  Calendercontroller calendercontroller = Get.put(Calendercontroller());

  @override
  void initState() {
    super.initState();
    print(Get.arguments['date']);
    Future.delayed(Duration.zero, () {
      getuser();
      homeController.fetchYogaSubcollections();
      homeController.fetchMusicSubcollections();
      homeController.setYogaStyle = '';
      homeController.setMusic = '';
      homeController.setSavanaTime = '';
      homeController.setIntensityLevel = '';
    });
  }

  getuser() async {
    await socialAuthController.getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: BGDarkCoverImage(
            image: AppImages.scheduleNetwork,
            child: Obx(
              () => socialAuthController.isLoading.isTrue
                  ? customLoading()
                  : Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryAppBar(
                                titleText: 'scheduleYourWorkout'.tr,
                                titleOnTap: () {
                                  // Get.to(VideoPlayList());
                                },
                                appbarColor: AppColors.TRANSPARENT_COLOR,
                                titleColor: AppColors.WHITE_COLOR,
                                isSuffix: false,
                                prefixIconImage: AppImages.arrowBack,
                                prefixButtonColor: AppColors.TRANSPARENT_COLOR,
                                prefixOnTap: () {
                                  Get.back();
                                },
                                suffixButtonColor: AppColors.TRANSPARENT_COLOR,
                                suffixIconImage: AppImages.calanderIcon,
                                suffixIconHeight: 30,
                                suffixIconWidth: 30,
                              ),
                              CircularProgress(
                                homeController: homeController,
                              ),
                            ]),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            maxChildSize: 0.9,
                            minChildSize: 0.5,
                            builder: (context, scrollController) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                height: Get.height * containerHeight,
                                width: Get.width,
                                padding: AppPaddings.defaultPadding,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      AppBorderRadius.BORDER_RADIUS_10,
                                  color: AppColors.BLACK.withOpacity(0.5),
                                ),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: AppColors.GRAY,
                                              borderRadius: AppBorderRadius
                                                  .BORDER_RADIUS_30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      vSizedBox(height: 10),
                                      AppText(
                                        text: "meditationTopics".tr,
                                        color: AppColors.WHITE_COLOR,
                                        fontWeight: FontWeight.bold,
                                        size: AppDimensions.FONT_SIZE_18,
                                      ),
                                      vSizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: yogaLevelContainer(
                                                title: 'intensityLevel'.tr,
                                                homeController: homeController),
                                          ),
                                        ],
                                      ),
                                      vSizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: yogaStyleContainer(
                                              title: 'yogaStyle'.tr,
                                              homeController: homeController,
                                            ),
                                          ),
                                          hSizedBox(width: 10),
                                          Expanded(
                                            child: musicContainer(
                                                title: 'selectmusic'.tr,
                                                homeController: homeController),
                                          ),
                                        ],
                                      ),
                                      vSizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: savasanaContainer(
                                                title: 'savasana'.tr,
                                                homeController: homeController),
                                          ),
                                        ],
                                      ),
                                      vSizedBox(height: 10),
                                      AppButton(
                                        buttonName: 'schedule'.tr,
                                        buttonWidth: Get.width,
                                        buttonColor: AppColors.PRIMARY_COLOR,
                                        textColor: AppColors.WHITE_COLOR,
                                        onTap: scheduleWorkoutsOnfirebase,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
            )),
      ),
      bottomSheet: null,
    );
  }

  scheduleWorkoutsOnfirebase() {
    if (homeController.videoLink.value == '') {
      customSnackBar(title: "pleaseSelectYogaTopic".tr);
    } else if (homeController.musicLink.value == '') {
      customSnackBar(title: "pleaseSelectmusic".tr);
    } else if (homeController.getSavanaTime == '') {
      customSnackBar(title: "pleaseSelectSavasanaTime".tr);
    } else if (homeController.getIntensityLevel == '') {
      customSnackBar(title: "pleaseSelectIntensity".tr);
    } else {
      calendercontroller.setScheduleWorkOut(
        savasanaTime: homeController.getSavanaTime,
        scheduleDate: Get.arguments['date'],
        videoLink: homeController.videoLink.value,
        workOutTime: homeController.getSelectedTime,
        musicLink: homeController.musicLink.value,
        musicType: homeController.getMusic,
        yogaType: homeController.getYogaStyle,
        intensity: homeController.getIntensityLevel,
        workoutStatus: ScheduleStatus.pending.name,
      );
      // Get.toNamed(
      //   Routes.onGoingWorkOut,
      //   arguments: {
      //     "videoLink": homeController.videoLink.value,
      //     "audioLink": homeController.musicLink.value,
      //     "audioDuration": homeController.musicDuration.value,
      //     "videoDuration": homeController.videoDuration,
      //     "selectedTime": homeController.getSelectedTime,
      //     "savasanaTime": homeController.getSavanaTime,
      //     "audiotype": homeController.getMusic,
      //   },
      // );
    }
  }
}
