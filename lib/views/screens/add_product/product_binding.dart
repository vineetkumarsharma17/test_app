import 'package:get/get.dart';
import 'package:test_app/views/screens/add_product/product_controller.dart';

import 'package:test_app/views/screens/home_view/home_controller.dart';

class ProductBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProductController());
  }
}
