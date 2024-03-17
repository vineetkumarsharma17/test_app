import 'package:get/get.dart';

import 'package:test_app/views/screens/home_view/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
  }
}
