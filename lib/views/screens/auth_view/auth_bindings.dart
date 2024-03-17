import 'package:get/get.dart';
import 'package:test_app/views/screens/auth_view/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
  }
}
