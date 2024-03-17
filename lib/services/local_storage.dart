import 'package:get_storage/get_storage.dart';

class StorageService {
  static GetStorage instance = GetStorage();

  static String? get getPhoneNumber => instance.read('phone');
  static set setPhoneNumber(String value) => instance.write('phone', value);

  static set setToken(String value) => instance.write('token', value);
  static String? get getToken => instance.read('token');

  static set setFCMToken(String value) => instance.write('fcm_token', value);
  static String? get getFCMToken => instance.read('fcm_token');

  static setLoggedIn() => instance.write('isLoggedIn', true);
  static bool get isLoggedIn => instance.read('isLoggedIn') ?? false;

  static void logout() => instance.erase();
}
