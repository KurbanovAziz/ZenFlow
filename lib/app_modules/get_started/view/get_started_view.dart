import 'package:zen_flow/utils/Widgets/auth_sheet.dart';

import '../../../utils/Widgets/staggered_grid_view.dart';
import '../../../utils/app_imports/app_imports.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: AppPaddings.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vSizedBox(height: Get.height * 0.25),
          AppText(
              text: 'app_name'.tr,
              textAlign: TextAlign.center,
              size: AppDimensions.FONT_SIZE_40,
              color: whiteOnPrimary,
              fontWeight: FontWeight.w800),
          vSizedBox(height: Get.height * 0.1),
          const Spacer(),
          AppButton(
              buttonWidth: Get.width,
              buttonName: 'create_account_btn'.tr,
              buttonColor: whiteOnPrimary,
              textColor: blackOnPrimary,
              onTap: () {
                bottomSheet(child: AuthBottomSheet());
              }),
          vSizedBox(),
          AppButton(
              buttonWidth: Get.width,
              buttonName: 'sign_in'.tr,
              borderColor: whiteOnPrimary,
              buttonColor: AppColors.TRANSPARENT_COLOR,
              textColor: whiteOnPrimary,
              onTap: () {
                Get.to(StaggeredGridScreen());
                // Get.to(AppBottomBarCall(
                //   title: '',
                // ));
                //  bottomSheet(
                //      child: AuthBottomSheet(
                //    tab: 1,
                //  ));
              }),
          const Spacer(),
          AppText(
            text: 'privacy_policy'.tr,
            textAlign: TextAlign.center,
            size: AppDimensions.FONT_SIZE_12,
            color: whiteOnPrimary,
          ),
          vSizedBox(height: Get.height * 0.04),
        ],
      ),
    ));
  }
}
