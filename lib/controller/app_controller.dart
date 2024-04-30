import 'dart:developer';

import 'package:get/get.dart';
import 'package:test_app/services/local_storage.dart';
import 'package:test_app/views/screens/auth_view/login_view.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/views/screens/home_view/home_view.dart';

import '../services/http_service.dart';
import '../views/screens/auth_view/auth_bindings.dart';
import '../views/screens/home_view/home_bindings.dart';
import '../views/screens/scanner/scanner.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  Rx<User?> user = Rx<User?>(null);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initialCheck();
    ever(user,
        (callback) => handleRoute(callback)); // Listening for user changes
  }

  void initialCheck() async {
    // StorageService.logout();
    if (StorageService.getCredential != null) {
      Map<String, String> data = {};
      StorageService.getCredential!.entries.forEach((obj) {
        data[obj.key] = obj.value as String;
      });
      User? user = await HttpService.instance.login(data);
      this.user(user);
    } else {
      handleRoute(
        null,
      );
    }
  }

  void handleRoute(
    User? user,
  ) {
    Future.delayed(Duration(seconds: 2), () {
      if (user != null) {
        Get.offAll(() => const HomeView(), binding: HomeBindings());
      } else {
        Get.offAll(
          () => const ScanView(),
        );
        // Get.offAll(() => const LogInView(), binding: AuthBindings());
      }
    });
  }
}

AppController appController = AppController.instance;

class AppInitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
  }
}
