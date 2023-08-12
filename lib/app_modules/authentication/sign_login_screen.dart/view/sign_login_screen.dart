import '../../../../config/binding_routing/app_pages.dart';
import '../../../../utils/app_imports/app_imports.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.splashImageNetwork,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: AppPaddings.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox(height: Get.height * 0.2),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    height: Get.height * 0.22,
                  ),
                ),
                vSizedBox(height: Get.height * 0.24),
                AppText(
                    text: 'getStarted'.tr,
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeight.w600,
                    size: AppDimensions.FONT_SIZE_28),
                AppText(
                  text: 'yogajourney'.tr,
                  color: AppColors.WHITE_COLOR,
                  // fontWeight: FontWeight.w600,
                  // size: AppDimensions.FONT_SIZE_28,
                ),
                vSizedBox(height: Get.height * 0.04),
                AppButton(
                    paddingButton: 1,
                    iconImage: AppImages.logo,
                    isCenter: true,
                    buttonWidth: Get.width,
                    buttonName: 'signIn'.tr,
                    buttonColor: AppColors.PRIMARY_COLOR,
                    textColor: AppColors.WHITE_COLOR,
                    onTap: () {
                      Get.offAllNamed(Routes.loginView);
                    }),
                vSizedBox(),
                AppButton(
                    paddingButton: 1,
                    iconImage: AppImages.logo,
                    isCenter: true,
                    buttonWidth: Get.width,
                    buttonName: 'signUp'.tr,
                    buttonColor: AppColors.PRIMARY_COLOR,
                    textColor: AppColors.WHITE_COLOR,
                    onTap: () {
                      Get.toNamed(Routes.registerView);
                    }),
                vSizedBox(height: Get.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
