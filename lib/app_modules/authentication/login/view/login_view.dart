import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_flow/utils/Widgets/customSnakbar.dart';
import 'package:zen_flow/utils/constants/app_constants.dart';

import '../../../../utils/app_imports/app_imports.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SocialAuthController socialAuthController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.splashImageNetwork,
        child: Column(
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
                child: Padding(
                  padding: AppPaddings.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // vSizedBox(height: Get.height * 0.05),
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppImages.logo,
                          height: Get.height * 0.22,
                        ),
                      ),
                      // vSizedBox(height: Get.height * 0.24),
                      AppText(
                          text: 'yourjourney'.tr,
                          color: AppColors.WHITE_COLOR,
                          fontWeight: FontWeight.w600,
                          size: AppDimensions.FONT_SIZE_28),
                      vSizedBox(height: Get.height * 0.04),

                      AppTextField(
                        controller: emailController,
                        hint: 'email'.tr,
                      ),
                      vSizedBox(),
                      AppTextField(
                        controller: passwordController,
                        hint: 'password'.tr,
                      ),
                      vSizedBox(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AppText(
                            text: 'forgotPassword'.tr,
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w400,
                            size: AppDimensions.FONT_SIZE_12),
                      ),
                      vSizedBox(height: Get.height * 0.05),
                      AppButton(
                          buttonWidth: Get.width,
                          buttonName: 'signIn'.tr,
                          buttonColor: AppColors.PRIMARY_COLOR,
                          textColor: AppColors.WHITE_COLOR,
                          onTap: () {
                            if (emailController.text == '' ||
                                passwordController.text == '') {
                              customSnackBar(title: 'allfieldrequired'.tr);
                            } else {
                              if (!GetUtils.isEmail(emailController.text)) {
                                customSnackBar(title: 'emailNotValid'.tr);
                              } else {
                                _signInWithEmailAndPassword();
                              }
                            }
                          }),
                      vSizedBox(height: Get.height * 0.04),
                      Align(
                        alignment: Alignment.center,
                        child: AppText(
                            text: '---------- ' + 'or'.tr + ' ----------',
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w400,
                            size: AppDimensions.FONT_SIZE_16),
                      ),

                      vSizedBox(height: Get.height * 0.04),
                      // AppText(
                      //   text: 'desiredSocial'.tr,
                      //   color: AppColors.WHITE_COLOR,
                      //   // fontWeight: FontWeight.w600,
                      //   // size: AppDimensions.FONT_SIZE_28,
                      // ),
                      vSizedBox(),
                      Obx(
                        () => socialAuthController.isLoading.isTrue
                            ? customLoading(color: AppColors.PRIMARY_COLOR)
                            : AppButton(
                                isIcon: true,
                                paddingButton: 1,
                                iconImage: AppImages.faceBookLogopng,
                                isCenter: true,
                                buttonWidth: Get.width,
                                buttonName: 'signInFb'.tr,
                                borderColor: whiteOnPrimary,
                                buttonColor: AppColors.WHITE_COLOR,
                                textColor: AppColors.BLACK,
                                onTap: () {
                                  customSnackBar(
                                    title: 'After Being Live it will work',
                                  );
                                  // socialAuthController.loginWithFacebook(context);
                                }),
                      ),
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
                                buttonName: 'signInGoogle'.tr,
                                borderColor: whiteOnPrimary,
                                buttonColor: AppColors.WHITE_COLOR,
                                textColor: AppColors.BLACK,
                                onTap: () {
                                  socialAuthController.loginInWithGoogle(
                                    isLogin: false,
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
                                buttonName: 'signInApple'.tr,
                                borderColor: whiteOnPrimary,
                                buttonColor: AppColors.WHITE_COLOR,
                                textColor: AppColors.BLACK,
                                onTap: () {
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.toNamed(Routes.homeView);
      prefs.setString(AppConstants.isLogin, 'true');

      // User signed in successfully.
      // You can navigate to another page or perform any other desired actions.
      print('User signed in: ${userCredential.user}');
    } catch (e) {
      // Handle sign-in errors.
      print('Failed to sign in: $e');
      customSnackBar(title: e.toString());
    }
  }
}
