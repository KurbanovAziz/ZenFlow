import '../../Utils/app_imports/app_imports.dart';
import '../Fonts/AppFonts.dart';

class AuthBottomSheet extends StatelessWidget {
  int tab;

  AuthBottomSheet({Key? key, this.tab = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: tab,
        length: 2,
        child: Padding(
          padding: AppPaddings.horizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: AppPaddings.vertical,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 4,
                    width: 50,
                    decoration: const BoxDecoration(color: whiteGrey),
                  ),
                ),
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                labelColor: whiteOnPrimary,
                onTap: (val) {
                  debugPrint('this is tab tp $val');
                  if (val == 1) {}
                },
                labelStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeights.medium),
                unselectedLabelColor: whiteGrey,
                indicatorColor: whiteOnPrimary,
                indicatorWeight: 2,
                tabs: const [
                  Tab(text: 'Sign Up'),
                  Tab(text: 'Sign In'),
                ],
              ),
              SizedBox(
                height: Get.height / 2,
                child: TabBarView(
                  children: [
                    socialLoginAuthWidget(),
                    socialLoginAuthWidget(isSignIn: true),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget socialLoginAuthWidget({bool isSignIn = false}) {
  return Column(
    children: [
      vSizedBox(),
      AppText(
        text: 'sign_up_text'.tr,
        size: AppDimensions.FONT_SIZE_16,
        color: whiteOnPrimary,
      ),
      vSizedBox(),
      AppButton(
          isIcon: true,
          paddingButton: 1,
          iconImage: AppImages.logo,
          isCenter: true,
          buttonWidth: Get.width,
          buttonName: isSignIn ? 'sign_in_phone'.tr : 'sign_up_phone'.tr,
          borderColor: whiteOnPrimary,
          buttonColor: AppColors.TRANSPARENT_COLOR,
          textColor: whiteOnPrimary,
          onTap: () {}),
      vSizedBox(),
      AppButton(
          isIcon: true,
          paddingButton: 1,
          iconImage: AppImages.logo,
          isCenter: true,
          buttonWidth: Get.width,
          buttonName: isSignIn ? 'sign_in_google'.tr : 'sign_up_google'.tr,
          borderColor: whiteOnPrimary,
          buttonColor: AppColors.TRANSPARENT_COLOR,
          textColor: whiteOnPrimary,
          onTap: () {}),
      vSizedBox(),
      AppButton(
          isIcon: true,
          paddingButton: 1,
          iconImage: AppImages.logo,
          isCenter: true,
          buttonWidth: Get.width,
          buttonName: isSignIn ? 'sign_in_fb'.tr : 'sign_up_fb'.tr,
          borderColor: whiteOnPrimary,
          buttonColor: AppColors.TRANSPARENT_COLOR,
          textColor: whiteOnPrimary,
          onTap: () {}),
      const Spacer(),
      AppText(
        text: 'privacy_policy'.tr,
        textAlign: TextAlign.center,
        size: AppDimensions.FONT_SIZE_12,
        color: whiteOnPrimary,
      ),
      vSizedBox(height: Get.height * 0.04),
    ],
  );
}
