import 'dart:io';

import 'package:zen_flow/app_modules/subscription/view/cant_afford.dart';
import 'package:zen_flow/utils/Enums/enums.dart';

import '../../../utils/app_imports/app_imports.dart';

class SubscriptionView extends StatelessWidget {
  SubscriptionView({super.key});

  SocialAuthController socialAuthController = Get.find();
  SubscriptionController subscriptionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.subscriptionImageNetwork,
        child: Column(
          children: [
            PrimaryAppBar(
              titleText: 'subscription'.tr,
              appbarColor: AppColors.TRANSPARENT_COLOR,
              titleColor: AppColors.WHITE_COLOR,
              isSuffix: false,
              prefixButtonColor: AppColors.TRANSPARENT_COLOR,
              isPrefix: Get.arguments == false ? false : true,
              prefixOnTap: () {
                Get.back();
              },
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: AppPaddings.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: subcriptionContainer(
                                ontap: () {
                                  subscriptionController.setSubscriptionType =
                                      SubscriptionType.yearly.name.toString();
                                },
                                borderColor: subscriptionController
                                            .getSubscriptionType ==
                                        SubscriptionType.yearly.name.toString()
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.TRANSPARENT_COLOR,
                                title: 'yearly'.tr,
                                subPrice: '4 690,00 RUB',
                                perSub: 'peryear'.tr,
                                subDetail: '390,83 RUB/month'),
                          ),
                          hSizedBox(width: 08),
                          Expanded(
                            child: subcriptionContainer(
                                ontap: () {
                                  subscriptionController.setSubscriptionType =
                                      SubscriptionType.monthly.name.toString();
                                },
                                borderColor: subscriptionController
                                            .getSubscriptionType ==
                                        SubscriptionType.monthly.name.toString()
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.TRANSPARENT_COLOR,
                                title: 'monthly'.tr,
                                subPrice: '4 690,00 RUB',
                                perSub: 'permonth'.tr,
                                subDetail: 'Recurring Subscription'),
                          ),
                        ],
                      ),
                      vSizedBox(),
                      Get.arguments == false
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                Expanded(
                                  // flex: 7,
                                  child: freeTrailContainer(
                                    ontap: () {
                                      subscriptionController
                                              .setSubscriptionType =
                                          SubscriptionType.free.name.toString();
                                    },
                                    borderColor: subscriptionController
                                                .getSubscriptionType ==
                                            SubscriptionType.free.name
                                                .toString()
                                        ? AppColors.WHITE_COLOR
                                        : AppColors.TRANSPARENT_COLOR,
                                    title: 'freeTrail'.tr,
                                    subtitle: 'freeTrailgives'.tr,
                                  ),
                                )
                              ],
                            ),
                      vSizedBox(),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       // flex: 7,
                      //       child: freeTrailContainer(
                      //         ontap: () {
                      //           subscriptionController.setSubscriptionType =
                      //               SubscriptionType.cantafford.name.toString();
                      //         },
                      //         borderColor:
                      //             subscriptionController.getSubscriptionType ==
                      //                     SubscriptionType.cantafford.name
                      //                         .toString()
                      //                 ? AppColors.WHITE_COLOR
                      //                 : AppColors.TRANSPARENT_COLOR,
                      //         title: 'cantAffordZenflow'.tr,
                      //         subDetail: 'cantAfford'.tr,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Spacer(),

                      vSizedBox(),
                      if (Platform.isAndroid) ...{
                        AppButton(
                            buttonWidth: Get.width,
                            buttonName: 'payWithGoogle'.tr,
                            buttonColor: subscriptionController
                                    .getSubscriptionType.isNotEmpty
                                ? AppColors.PRIMARY_COLOR
                                : AppColors.GRAY,
                            textColor: AppColors.WHITE_COLOR,
                            onTap: () {
                              subscriptionController.subScriptionFunction();
                            }),
                      } else if (Platform.isIOS) ...{
                        AppButton(
                            buttonWidth: Get.width,
                            buttonName: 'payWithApple'.tr,
                            buttonColor: subscriptionController
                                    .getSubscriptionType.isNotEmpty
                                ? AppColors.PRIMARY_COLOR
                                : AppColors.GRAY,
                            textColor: AppColors.WHITE_COLOR,
                            onTap: () {
                              subscriptionController.subScriptionFunction();
                            }),
                      },
                      vSizedBox(),
                      //   Align(
                      //   alignment: Alignment.center,
                      //   child:
                      // ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(CantAffordApp());
                                },
                                child: AppText(
                                  text: 'cantAffordZenflow'.tr,
                                  color: AppColors.WHITE_COLOR,
                                  underLine: TextDecoration.underline,
                                )),
                            vSizedBox(),
                            AppText(
                                text: 'privacyPolicy'.tr,
                                color: AppColors.WHITE_COLOR,
                                size: AppDimensions.FONT_SIZE_12),
                          ],
                        ),
                      ),
                      vSizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
