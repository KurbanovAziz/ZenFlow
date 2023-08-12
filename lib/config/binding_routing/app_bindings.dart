import '../../utils/app_imports/app_imports.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}

class GetStartedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStartedController>(
      () => GetStartedController(),
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<SocialAuthController>(
      () => SocialAuthController(),
    );
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<SocialAuthController>(
      () => SocialAuthController(),
    );
  }
}

class QuestiopnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionController>(
      () => QuestionController(),
    );
  }
}

class OnGoingWorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnGoingWorkoutController>(
      () => OnGoingWorkoutController(),
    );
  }
}

class CalenderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Calendercontroller>(
      () => Calendercontroller(),
    );
  }
}

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(
      () => ResultController(),
    );
  }
}

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
  }
}

class TrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingController>(
      () => TrainingController(),
    );
  }
}

class ScheduleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Calendercontroller>(
      () => Calendercontroller(),
    );
  }
}

// class ScheduleVideoPlayerBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<Calendercontroller>(
//       () => Calendercontroller(),
//     );
//   }
// }

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SocialAuthController>(
      () => SocialAuthController(),
    );
  }
}
