part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const initialRoute = _Paths.initialRoute;
  static const getStarted = _Paths.getStarted;
  static const loginView = _Paths.loginView;
  static const registerView = _Paths.registerView;
  static const resultView = _Paths.resultView;
  static const subscriptionView = _Paths.subscriptionView;
  static const trainingView = _Paths.trainingView;
  static const questionView = _Paths.questionView;
  static const onGoingWorkOut = _Paths.onGoingWorkOut;
  static const calenderScreen = _Paths.calenderScreen;
  static const homeView = _Paths.homeView;
  static const scheduleWWorkOut = _Paths.scheduleWWorkOut;
  // static const scheduleVideoPlayer = _Paths.scheduleVideoPlayer;
}

abstract class _Paths {
  _Paths._();

  static const initialRoute = '/';
  static const getStarted = '/GetStarted';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const resultView = '/resultView';
  static const subscriptionView = '/subscriptionView';
  static const trainingView = '/trainingView';
  static const questionView = '/questionView';
  static const onGoingWorkOut = '/onGoingWorkOut';
  static const calenderScreen = '/calenderScreen';
  static const homeView = '/homeView';
  static const scheduleWWorkOut = '/scheduleWWorkOut';
  // static const scheduleVideoPlayer = '/scheduleVideoPlayer';
}
