import 'package:firebase_core/firebase_core.dart';

import 'package:get_storage/get_storage.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

import 'App/my_app.dart';
import 'config/firebase/fcm_notification.dart';

final storageBox = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // - For Firebase
  await Firebase.initializeApp();
  await initMessaging();
  await GetStorage.init();

  // checkInternetConnection();

  runApp(MyApp());
}


/////youtube api key
// AIzaSyDio2Rhov4uAyWt1YUZhoKu6FY_-OBK2qQ