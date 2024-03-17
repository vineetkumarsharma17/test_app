import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class StorageService {
  static GetStorage instance = GetStorage();

  // static set setToken(String value) => instance.write('token', value);
  // static String? get getToken => instance.read('token');

  static set setCredential(Map<String, String>? value) =>
      instance.write('credential', value);
  static Map? get getCredential => instance.read('credential');

  // static setLoggedIn() => instance.write('isLoggedIn', true);
  // static bool get isLoggedIn => instance.read('isLoggedIn') ?? false;

  static void logout() => instance.erase();
}
