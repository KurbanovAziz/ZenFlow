import 'package:zen_flow/app_modules/calender/view/calender.dart';
import 'package:zen_flow/app_modules/calender/view/schedule_video_play.dart';

import '../../app_modules/calender/view/schedule_work_out.dart';
import '../../utils/app_imports/app_imports.dart';
import 'app_bindings.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.initialRoute;

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.initialRoute,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.getStarted,
      page: () => GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.loginView,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.registerView,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.questionView,
      page: () => QuestionView(),
      binding: QuestiopnBinding(),
    ),
    GetPage(
      name: _Paths.onGoingWorkOut,
      page: () => OnGoingWorkOut(),
      binding: OnGoingWorkoutBinding(),
    ),
    GetPage(
      name: _Paths.calenderScreen,
      page: () => CalenderScreen(),
      binding: CalenderScreenBinding(),
    ),
    GetPage(
      name: _Paths.resultView,
      page: () => ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: _Paths.subscriptionView,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.trainingView,
      page: () => TrainingView(),
      binding: TrainingBinding(),
    ),
    GetPage(
      name: _Paths.homeView,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.scheduleWWorkOut,
      page: () => ScheduleWWorkOut(),
      binding: ScheduleScreenBinding(),
    ),
    // GetPage(
    //   name: _Paths.scheduleVideoPlayer,
    //   page: () => ScheduleVideoPlayer(),
    //   binding: ScheduleVideoPlayerBinding(),
    // ),
  ];
}
