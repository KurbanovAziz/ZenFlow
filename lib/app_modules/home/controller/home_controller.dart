import 'dart:developer' as dev;
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  @override
  void onReady() {
    fetchYogaSubcollections();
    fetchMusicSubcollections();
    super.onReady();
  }

///////////////Timer Yoga time//////////////////
  final _initialTime = ''.obs;
  set setTime(value) => _initialTime.value = value;
  get getTime => _initialTime.value;

  List timeList = [
    '10 mins',
    '15 mins',
    '20 mins',
    '25 mins',
    '30 mins',
    '35 mins',
    '40 mins',
    '45 mins',
    '60 mins',
  ];
  /////////////////Music Type/////////////////////
  final _initialMusic = ''.obs;
  set setMusic(value) => _initialMusic.value = value;
  get getMusic => _initialMusic.value;
  List musicList = [
    'Love',
    'Nature',
    'Classical',
    'Ethnic Music',
  ];

////////////////////Meditation Topics/////////////////////////
  final _meditationTopic = ''.obs;
  set setMeditationTopic(value) => _meditationTopic.value = value;
  get getMeditationTopic => _meditationTopic.value;
  List meditationTopic = [
    'Love',
    'Money',
    'Peace',
    'Abundance',
    'Partner Relationships'
  ];
////////////////////////////////////////////////
  final _selectedTime = ''.obs;
  set setSelectedTime(value) => _selectedTime.value = value;
  get getSelectedTime => _selectedTime.value;

  ///////////////////yoga Style/////////////////////////
  final _yogaStyle = ''.obs;
  set setYogaStyle(value) => _yogaStyle.value = value;
  get getYogaStyle => _yogaStyle.value;
  // List yogaStyleList = [
  //   'Iyengar',
  //   'Strength Flow',
  //   'Cardio Flow',
  //   'Prenatal',
  //   'Ashtanga',
  //   'Vinyasa flow',
  //   'Kundalini',
  //   'Yoga Nidra',
  //   'Hatha',
  //   'Yin',
  //   'Gentle',
  //   'Flexibility Flow',
  //   'Sun Salutations',
  //   'Chair Yoga',
  //   'Rstorative'
  // ];

  /////////savasana time
  final _savanaTime = ''.obs;
  set setSavanaTime(value) => _savanaTime.value = value;
  get getSavanaTime => _savanaTime.value;
  List savasanaTimeList = [
    'None',
    '1 min',
    '2 mins',
    '3 mins',
    '4 mins',
    '5 mins',
    '6 mins',
    '7 mins',
    '8 mins',
    '9 mins',
    '10 mins',
    '11 mins',
    '12 mins',
    '13 mins',
    '14 mins',
    '15 mins',
  ];

////////////////////Meditation Topics/////////////////////////
  final _intensityLevel = ''.obs;
  set setIntensityLevel(value) => _intensityLevel.value = value;
  get getIntensityLevel => _intensityLevel.value;
  List intensityList = [
    'Beginner',
    'Intermediate',
    'Advance',
  ];

  ///////////////////////////////////fetching yoga subCat
  var yogaSubCollections = [].obs;

  void fetchYogaSubcollections() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('YogaStyle').get();

      // You can access each document's data as follows:
      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>;

        if (yogaSubCollections.contains(data['yoga_type'])) {
        } else {
          yogaSubCollections.add(data['yoga_type']);
        }
      }
      dev.log("list ${yogaSubCollections.toString()}");
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

/////////////////fetching yoga docIds
  var yogaDocIds = [].obs;
  fetchYogaVideoDocs({String? yogaType, String? intensitylevel}) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('YogaStyle').get();
      // You can access each document's data as follows:
      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>;
        if (data['yoga_type'] == yogaType) {
          if (data['intensity_level'] == intensitylevel) {
            if (!yogaDocIds.contains(data['id'])) {
              yogaDocIds.add(data['id']);
            }
            Get.back();
          } else {
            customSnackBar(title: 'videoDoesNotExit'.tr);
          }
        } else {}
      }
      String randomId = getRandomElement(yogaDocIds);
      getYogaVideoFromFirebase(docId: randomId);
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

  getRandomElement(var list) {
    if (list.isEmpty) {
      throw ArgumentError('The list must not be empty.');
    }
    dev.log('List ${list.toString()}');
    final randomIndex = Random().nextInt(list.length);
    final randomElementvalue = list[randomIndex];
    final copyOfList = list.toList(); // Create a copy of the list
    list.clear(); // Clear the original list
    return randomElementvalue;
  }

  ////////////////fetching music
  var musicSubCollections = [].obs;
  void fetchMusicSubcollections() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Music').get();

      // You can access each document's data as follows:
      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>;

        if (musicSubCollections.contains(data['music_type'])) {
        } else {
          musicSubCollections.add(data['music_type']);
        }
      }
      dev.log("list ${musicSubCollections.toString()}");
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

/////////////////fetching music docIds
  var musicDocIds = [].obs;
  fetchMusicDocs({String? musicType}) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Music').get();

      // You can access each document's data as follows:
      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>;
        dev.log('music Type $musicType');
        if (data['music_type'] == musicType) {
          if (!musicDocIds.contains(data['id'])) {
            musicDocIds.add(data['id']);
          } else {
            print('id is exist');
          }
        } else {
          print('music cat does not exist');
        }
      }
      String randomId = getRandomElement(musicDocIds);
      await getMusicFromFirebase(docId: randomId);
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

////////////////////////////get music
  var musicId = ''.obs;
  var musicDuration = ''.obs;
  var musicLink = ''.obs;
  var musicType = ''.obs;
  var musicDataTime = ''.obs;
  getMusicFromFirebase({String? docId}) async {
    try {
      isLoading(true);
      print('getMusicFromFirebase : $docId');
      print('isLoading $isLoading');
      musicId.value = "";
      musicDuration.value = "";
      musicLink.value = "";
      musicType.value = "";
      musicDataTime.value = "";
      FirebaseFirestore.instance
          .collection("Music")
          .doc(docId.toString())
          .get()
          .then((value) {
        musicId.value = value.data()!["id"];
        musicDuration.value = value.data()!["music_duration"];
        musicLink.value = value.data()!["music_url"];
        musicType.value = value.data()!["music_type"];
        musicDataTime.value = value.data()!["timestamp"];

        isLoading(false);
        update();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///////////////////////get Yoga from firebase
  var videoId = ''.obs;
  var videoDuration = ''.obs;
  var videoLink = ''.obs;
  var videoType = ''.obs;
  var videoDataTime = ''.obs;

  getYogaVideoFromFirebase({String? docId}) async {
    try {
      isLoading(true);
      print('isLoading $isLoading');

      await FirebaseFirestore.instance
          .collection("YogaStyle")
          .doc(docId.toString())
          .get()
          .then((value) {
        videoId.value = value.data()!["id"];
        videoDuration.value = value.data()!["video_duration"];
        videoLink.value = value.data()!["video_url"];
        videoType.value = value.data()!["yoga_type"];
        videoDataTime.value = value.data()!["timestamp"];

        isLoading(false);
        update();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
