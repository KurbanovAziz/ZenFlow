import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zen_flow/app_modules/question/model/questionnaire_model.dart';

import '../../../utils/app_imports/app_imports.dart';

class QuestionController extends GetxController {
  TextEditingController ageController = TextEditingController();
  SocialAuthController socialAuthController = Get.find();
  final _question = 0.obs;
  set setQuestion(value) => _question.value = value;
  get getQuestion => _question.value;

  List questions = [
    'q1-'.tr,
    'q2-'.tr,
    'q3-'.tr,
    'q4-'.tr,
    'q5-'.tr,
  ];
  List questionsHints = [
    'age'.tr,
    'gender'.tr,
    'level'.tr,
    'weightLossGoal'.tr,
    'timeTarget'.tr,
  ];

////////////////////////////////////////////////////////
  final _gernder = ''.obs;
  set setGender(value) => _gernder.value = value;
  get getGender => _gernder.value;
  List genderList = ['Male', 'Female'];
////////////////////////////////////////////////////////
  final _fitnesslevel = ''.obs;
  set setFitnesslevel(value) => _fitnesslevel.value = value;
  get getFitnesslevel => _fitnesslevel.value;
  List fitnessList = [
    'Very Poor',
    'Poor',
    'Fair',
    'Good',
    'Excellent',
    'Superior',
  ];
////////////////////////////////////////////////////////
  final _weightLossgoal = ''.obs;
  set setWightLossgoal(value) => _weightLossgoal.value = value;
  get getWeightLossgoal => _weightLossgoal.value;
  List weightLossgoalList = [
    '5 pounds',
    '10 pounds',
    '15 pounds',
    '20 pounds',
    '25 pounds',
    '35 pounds',
    '40 pounds',
    '45 pounds',
    '50 pounds',
    '55 pounds',
    '60 pounds',
  ];
  ////////////////////////////////////////////////
  final _dailyTimeTarget = ''.obs;
  set setDailyTimeTarget(value) => _dailyTimeTarget.value = value;
  get getDailyTimeTarget => _dailyTimeTarget.value;
  List dailyTimetargetList = [
    '15 Minutes',
    '20 Minutes',
    '30 Minutes',
    '45 Minutes',
    '60 Minutes',
  ];

  moveToNextquestion({var loginType, var subscriptionType}) {
    switch (getQuestion) {
      case 0:
        if (ageController.text.isNotEmpty) {
          setQuestion = getQuestion + 1;
        } else {
          customSnackBar(title: 'Please add you age');
        }
        break;
      case 1:
        if (getGender.isNotEmpty) {
          setQuestion = getQuestion + 1;
        } else {
          customSnackBar(title: 'Please select your gender');
        }
        break;
      case 2:
        if (getFitnesslevel.isNotEmpty) {
          setQuestion = getQuestion + 1;
        } else {
          customSnackBar(title: 'Please select your fitness level');
        }
        break;
      case 3:
        if (getWeightLossgoal.isNotEmpty) {
          setQuestion = getQuestion + 1;
        } else {
          customSnackBar(title: 'Please set your weight loss goal');
        }
        break;
      case 4:
        if (getDailyTimeTarget.isNotEmpty) {
          if (loginType == 'simple') {
            setQuestionOnFirebase();
          } else {
            socialAuthController.setUserDataOnFireBase(
                subscriptionType: subscriptionType, loginType: loginType);
            setQuestionOnFirebase();
          }
        } else {
          customSnackBar(title: 'Please select the time you can spend daily');
        }
        break;
      default:
        print('default');
        // Perform actions for unknown fruits
        break;
    }
  }

  setQuestionOnFirebase() async {
    var questionnaire = Questionnaire(
      userId: FirebaseAuth.instance.currentUser!.uid,
      age: ageController.text,
      gender: getGender,
      fitnessLevel: getFitnesslevel,
      weightLossGoal: getWeightLossgoal,
      dailyTime: getDailyTimeTarget,
    );

    FirebaseFirestore.instance
        .collection('Questionnaire')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(questionnaire.toJson())
        .then((value) => {Get.toNamed(Routes.subscriptionView)});
  }
}
