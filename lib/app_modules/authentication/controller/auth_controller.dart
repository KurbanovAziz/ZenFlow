import '../../../utils/app_imports/app_imports.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
