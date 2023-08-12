import '../../../utils/app_imports/app_imports.dart';

class CantAffordApp extends StatelessWidget {
  CantAffordApp({super.key});
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
          image: AppImages.questionImageNetwork,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryAppBar(
                titleText: 'cantafford'.tr,
                appbarColor: AppColors.TRANSPARENT_COLOR,
                titleColor: AppColors.WHITE_COLOR,
                isSuffix: false,
                prefixIconHeight: 20,
                prefixIconWidth: 20,
                prefixIconImage: AppImages.arrowBack,
                prefixButtonColor: AppColors.TRANSPARENT_COLOR,
                prefixOnTap: () async {
                  Get.back();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'cantaffordDiscription'.tr,
                        color: AppColors.WHITE_COLOR,
                      ),
                      vSizedBox(),
                      AppTextField(
                        controller: reasonController,
                        hint: 'yourSituation'.tr,
                        maxLines: 15,
                      ),
                      vSizedBox(),
                      AppButton(
                          buttonName: 'send'.tr,
                          buttonWidth: Get.width,
                          buttonColor: AppColors.PRIMARY_COLOR,
                          textColor: AppColors.WHITE_COLOR,
                          onTap: () {
                            customSnackBar(title: 'Coming Soon');
                          }),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
