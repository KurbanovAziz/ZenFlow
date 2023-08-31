import 'package:intl/intl.dart';
import 'package:zen_flow/app_modules/home/view/widget/yoga_level.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// String selectedValue = 'Love';
double containerHeight = 0.4; // Initial height

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  // AnimationController? _controller;
  // Animation<double>? _animation;
  // int _currentTime = 0;
  HomeController homeController = Get.find();
  SocialAuthController socialAuthController = Get.find();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getuser();
      homeController.fetchYogaSubcollections();
      homeController.fetchMusicSubcollections();
      homeController.setYogaStyle = '';
      homeController.setMusic = '';
      homeController.setSavanaTime = '';
      homeController.setIntensityLevel = '';
      // _currentTime = 20;
      // _controller = AnimationController(
      //   vsync: this,
      //   duration: Duration(seconds: _currentTime),
      // );

      // _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      //   ..addListener(() {
      //     setState(() {});
      //   });

      // startTimer();
    });

    performActionBasedOnChoice();
  }

  getuser() async {
    await socialAuthController.getUserData();
  }

  // void startTimer() {
  //   _controller!
  //       .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  //   _controller!.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       // Timer completed
  //       // Handle countdown completion here
  //     }
  //   });
  // }

  @override
  void dispose() {
    // _controller!.dispose();
    super.dispose();
  }

  String formatTime(int time) {
    int minutes = (time ~/ 60).toInt();
    int seconds = (time % 60).toInt();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void performActionBasedOnChoice() async {
    // print('subscriptionDate: ${socialAuthController.subscriptionDate.value}');
    String loginType = socialAuthController.subscriptionType.value;
    String date = socialAuthController.subscriptionDate.value;
    DateTime givenDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(date);

    DateTime currentTime = DateTime.now();
    DateTime? expirationDate;

    if (loginType == SubscriptionType.free.name.toString()) {
      expirationDate = givenDate.add(const Duration(days: 2));
    } else if (loginType == SubscriptionType.monthly.name.toString()) {
      expirationDate = givenDate
          .add(const Duration(days: 30)); // Assuming 30 days in a month
    } else if (loginType == SubscriptionType.yearly.name.toString()) {
      expirationDate = givenDate
          .add(const Duration(days: 365)); // Assuming 365 days in a year
    }

    if (currentTime.isBefore(expirationDate!)) {
      print("Current time is before the expiration date.");
    } else {
      print("Current time is on or after the expiration date.");
      Get.toNamed(Routes.subscriptionView, arguments: false);
      // Perform the desired action for the condition
      // This path is taken if the expiration date has been reached
    }
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
            image: AppImages.homeImageNetwork,
            child: Obx(
              () => socialAuthController.isLoading.isTrue
                  ? customLoading()
                  : Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryAppBar(
                                  titleText:
                                      '${'welcome'.tr} ${socialAuthController.userName.value.toString().split(' ').first}',
                                  titleOnTap: () {
                                    // Get.to(VideoPlayList());
                                  },
                                  appbarColor: AppColors.TRANSPARENT_COLOR,
                                  titleColor: AppColors.WHITE_COLOR,
                                  isSuffix: true,
                                  prefixIconHeight: 30,
                                  prefixIconWidth: 30,
                                  prefixIconImage: AppImages.personIcon,
                                  prefixButtonColor:
                                      AppColors.TRANSPARENT_COLOR,
                                  prefixOnTap: () async {
                                    // final prefs =
                                    //     await SharedPreferences.getInstance();
                                    // prefs.setString(
                                    //     AppConstants.isLogin, 'fasle');
                                    // customSnackBar(title: 'Logged Out');
                                    // Get.offAll(const LoginSignUpScreen());
                                  },
                                  suffixButtonColor:
                                      AppColors.TRANSPARENT_COLOR,
                                  suffixIconImage: AppImages.calanderIcon,
                                  suffixIconHeight: 30,
                                  suffixIconWidth: 30,
                                  suffixOnTap: () {
                                    Get.toNamed(Routes.calenderScreen);
                                    // Get.to(TestingTimer());
                                  }),
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
                                        buttonName: 'start'.tr,
                                        buttonWidth: Get.width,
                                        buttonColor: AppColors.PRIMARY_COLOR,
                                        textColor: AppColors.WHITE_COLOR,
                                        onTap: moveToWorkoutScreen,
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

  moveToWorkoutScreen() {
    if (homeController.videoLink.value == '') {
      customSnackBar(title: "pleaseSelectYogaTopic".tr);
    } else if (homeController.musicLink.value == '') {
      customSnackBar(title: "pleaseSelectmusic".tr);
    } else if (homeController.getSavanaTime == '') {
      customSnackBar(title: "pleaseSelectSavasanaTime".tr);
    } else if (homeController.getIntensityLevel == '') {
      customSnackBar(title: "pleaseSelectIntensity".tr);
    } else {
      Get.toNamed(
        Routes.onGoingWorkOut,
        arguments: {
          "isSchedules": false,
          "videoLink": homeController.videoLink.value,
          "audioLink": homeController.musicLink.value,
          "audioDuration": homeController.musicDuration.value,
          "videoDuration": homeController.videoDuration,
          "selectedTime": homeController.getSelectedTime,
          "savasanaTime": homeController.getSavanaTime,
          "audiotype": homeController.getMusic,
          "intensityLevel": homeController.getIntensityLevel,
          "video_id": "",
          'videotype': homeController.getYogaStyle
        },
      );
    }
  }
}
