import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zen_flow/utils/helper_functions.dart';

import '../../../utils/app_imports/app_imports.dart';

class OnGoingWorkoutController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
///////////////////////////////////////
  final _isTimerPaused = false.obs;
  set setTimerPaused(value) => _isTimerPaused.value = value;
  get getTimerPaused => _isTimerPaused.value;
/////////////////////////////////
  // final _initialTime = '10 mins'.obs;
  // set setTime(value) => _initialTime.value = value;
  // get getTime => _initialTime.value;
  ///////////////////////////////
  final _videoMute = true.obs;
  set setVideoMute(value) => _videoMute.value = value;
  get getVideoMute => _videoMute.value;
///////////////////////////////////////////////
  final _videoFullScreen = false.obs;
  set setVideoFullScreen(value) => _videoFullScreen.value = value;
  get getVideoFullScreen => _videoFullScreen.value;
  //////////////////////////////////////////////////////
  final _musicPlaying = true.obs;
  set setMusicPlaying(value) => _musicPlaying.value = value;
  get getMusicPlaying => _musicPlaying.value;

  setUserProgress({
    String? sessionStatus,
    String? sessionDuration,
  }) async {
    var random = HelperFunctions().getRandomString(16);
    await FirebaseFirestore.instance
        .collection('UsersProgress')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('progess')
        .doc(random)
        .set({
      'userid': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': DateTime.now().toString(),
      'session_status': sessionStatus,
      'session_duration': sessionDuration,
      'calories_burned': '',
    });
  }

  // List timeList = [
  //   '10 mins',
  //   '15 mins',
  //   '20 mins',
  //   '25 mins',
  //   '30 mins',
  //   '35 mins',
  //   '40 mins',
  //   '45 mins',
  //   '60 mins',
  // ];
}
