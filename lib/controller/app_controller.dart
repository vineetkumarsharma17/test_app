import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

class AppInitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
  }
}
