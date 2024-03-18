import 'dart:developer';

import 'package:test_app/models/product.dart';
import 'package:test_app/services/http_service.dart';
import 'package:test_app/services/local_storage.dart';

import '../../../helper/app_export.dart';
import '../../../helper/helper.dart';
import '../../widgets/show_loading.dart';

class HomeController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  RxList<Product> productsList = RxList<Product>([]);
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }

  void getProducts([bool loading = false]) async {
    isLoading(true);
    try {
      log('run');
      productsList.clear();
      productsList.value = await HttpService.instance.getProducts();
    } catch (e) {
      log("error $e");
    } finally {
      isLoading(false);
    }
  }

  void deleteProduct(String id) async {
    showLoading();
    Map<String, String> jsonPrm = {
      "id": id,
      "user_login_token": appController.user.value!.userToken!,
    };
    var res = await HttpService.instance.deleteProduct(jsonPrm);
    dismissLoadingWidget();
    if (res != null) {
      Get.back();
      Helpers.toast(res['message']);
      Get.find<HomeController>()
          .productsList
          .removeWhere((value) => value.id == id);
    }
  }

  void signOut() async {
    StorageService.logout();
    appController.user.value = null;

    log("message");
  }
}
