import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final RxString _username = 'Unknown user'.obs;
  String get username => _username.value;
  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() {
    _username.value = _getStorage.read('username') ?? 'Unknown user';
    super.onInit();
  }

  void changeUsername(String value) {
    _username.value = value;
    _getStorage.write('username', value);
  }
}
