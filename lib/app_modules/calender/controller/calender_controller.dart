import 'package:zen_flow/utils/app_imports/app_imports.dart';

class Calendercontroller extends GetxController {
  final _isDateSelected = false.obs;
  set setDateSelected(value) => _isDateSelected.value = value;
  get getDateSelected => _isDateSelected.value;

  setScheduleWorkOut({
    String? scheduleDate,
    String? workOutTime,
    String? musicLink,
    String? videoLink,
    String? savasanaTime,
    String? musicType,
    String? yogaType,
    String? intensity,
    String? workoutStatus,
  }) async {
    var random = HelperFunctions().getRandomString(16);
    await FirebaseFirestore.instance
        .collection('AllUserScheduleWorkOut')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('SchedulesWorkOut')
        .doc(random)
        .set({
      'id': random.toString(),
      'timestamp': DateTime.now().toString(),
      'schedule_date': scheduleDate,
      'workout_time': workOutTime,
      'music_link': musicLink,
      'video_link': videoLink,
      'savasana_time': savasanaTime,
      'music_type': musicType,
      'yoga_type': yogaType,
      'intensity_level': intensity,
      'workout_status': workoutStatus,
    }).then((value) => {
              customSnackBar(title: "workoutScheduled".tr),
              Get.toNamed(Routes.calenderScreen),
            });
  }

  updateScheduleVideoStatus({
    String? id,
    String? workoutStatus,
  }) async {
    print('id: $id');
    print('workoutStatus: $workoutStatus');
    await FirebaseFirestore.instance
        .collection('AllUserScheduleWorkOut')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('SchedulesWorkOut')
        .doc(id.toString())
        .update({
      'workout_status': workoutStatus,
    });
  }
}
