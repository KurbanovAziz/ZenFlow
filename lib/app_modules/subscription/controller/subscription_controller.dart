import 'package:zen_flow/utils/Enums/enums.dart';

import '../../../utils/app_imports/app_imports.dart';

class SubscriptionController extends GetxController {
  SocialAuthController socialAuthController = Get.find();

  final _subscriptionType = ''.obs;
  set setSubscriptionType(value) => _subscriptionType.value = value;
  get getSubscriptionType => _subscriptionType.value;

  subScriptionFunction() {
    if (getSubscriptionType.isNotEmpty) {
      switch (getSubscriptionType) {
        case 'yearly':
          if (getSubscriptionType == SubscriptionType.yearly.name.toString()) {
            socialAuthController.updateSubscription(type: getSubscriptionType);
            setSubscriptionType = '';
          }
          break;
        case 'monthly':
          if (getSubscriptionType == SubscriptionType.monthly.name.toString()) {
            socialAuthController.updateSubscription(type: getSubscriptionType);
            setSubscriptionType = '';
          }
          break;
        case 'free':
          if (getSubscriptionType == SubscriptionType.free.name.toString()) {
            socialAuthController.updateSubscription(type: getSubscriptionType);
            setSubscriptionType = '';
          }
          break;
      }
    } else {
      customSnackBar(title: 'Please Select Subscription');
    }
  }
}
