import 'dart:io';
import 'package:zen_flow/app_modules/authentication/register/view/widget/signup_with_email.dart';

import '../../../../Utils/app_imports/app_imports.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  SocialAuthController socialAuthController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.splashImageNetwork,
        child: Padding(
          padding: AppPaddings.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryAppBar(
                titleText: '',
                appbarColor: AppColors.TRANSPARENT_COLOR,
                isSuffix: false,
                prefixButtonColor: AppColors.TRANSPARENT_COLOR,
                prefixOnTap: () {
                  Get.back();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppImages.logo,
                          height: Get.height * 0.22,
                        ),
                      ),
                      // vSizedBox(height: Get.height * 0.24),
                      AppText(
                          text: 'signUp'.tr,
                          color: AppColors.WHITE_COLOR,
                          fontWeight: FontWeight.w600,
                          size: AppDimensions.FONT_SIZE_28),
                      // AppText(
                      //   text: 'trialTwoDays'.tr,
                      //   color: AppColors.WHITE_COLOR,
                      //   // fontWeight: FontWeight.w600,
                      //   // size: AppDimensions.FONT_SIZE_28,
                      // ),

                      vSizedBox(),
                      SignUpWithEmail(
                          socialAuthController: socialAuthController),
                      Align(
                        alignment: Alignment.center,
                        child: AppText(
                            text: '---------- ${'or'.tr} ----------',
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w400,
                            size: AppDimensions.FONT_SIZE_16),
                      ),

                      vSizedBox(height: Get.height * 0.04),

                      Obx(() => socialAuthController.isLoading.isTrue
                          ? customLoading(color: AppColors.PRIMARY_COLOR)
                          : AppButton(
                              isIcon: true,
                              paddingButton: 1,
                              iconImage: AppImages.faceBookLogopng,
                              isCenter: true,
                              buttonWidth: Get.width,
                              buttonName: 'signUpFb'.tr,
                              borderColor: whiteOnPrimary,
                              buttonColor: AppColors.WHITE_COLOR,
                              textColor: AppColors.BLACK,
                              onTap: () {
                                // Get.toNamed(Routes.questionView);
                                customSnackBar(
                                  title: 'After Being Live it will work',
                                );
                              })),
                      vSizedBox(),
                      if (Platform.isAndroid) ...{
                        Obx(() => socialAuthController.isLoadingGoogle.isTrue
                            ? customLoading(color: AppColors.PRIMARY_COLOR)
                            : AppButton(
                                isIcon: true,
                                paddingButton: 1,
                                iconImage: AppImages.googleLogopng,
                                isCenter: true,
                                buttonWidth: Get.width,
                                buttonName: 'signUpGoogle'.tr,
                                borderColor: whiteOnPrimary,
                                buttonColor: AppColors.WHITE_COLOR,
                                textColor: AppColors.BLACK,
                                onTap: () async {
                                  // User? user = await
                                  socialAuthController.loginInWithGoogle(
                                    isLogin: false,
                                    subscriptionType:
                                        SubscriptionType.free.name.toString(),
                                    loginType: LoginType.google.name.toString(),
                                  );
                                })),
                      } else if (Platform.isIOS) ...{
                        Obx(() => socialAuthController.isLoading.isTrue
                            ? customLoading(color: AppColors.PRIMARY_COLOR)
                            : AppButton(
                                isIcon: true,
                                paddingButton: 1,
                                iconImage: AppImages.appleLogopng,
                                isCenter: true,
                                buttonWidth: Get.width,
                                buttonName: 'signUpApple'.tr,
                                borderColor: whiteOnPrimary,
                                buttonColor: AppColors.WHITE_COLOR,
                                textColor: AppColors.BLACK,
                                onTap: () {
                                  // Get.toNamed(Routes.questionView);
                                  customSnackBar(
                                    title: 'After Being Live it will work',
                                  );
                                })),
                      },
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
