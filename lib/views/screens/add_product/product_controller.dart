import 'package:test_app/helper/app_export.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/services/http_service.dart';
import 'package:test_app/views/screens/home_view/home_controller.dart';
import 'package:test_app/views/widgets/show_loading.dart';

import '../../../helper/helper.dart';

class ProductController extends GetxController {
  RxBool isEdit = false.obs;
  Product? editableProduct;
  TextEditingController nameTextCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController moqCtrl = TextEditingController();
  TextEditingController discountPriceCtrl = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      editableProduct = (Get.arguments);
      isEdit(true);
      nameTextCtrl.text = editableProduct!.name!;
      priceCtrl.text = editableProduct!.price!;
      moqCtrl.text = editableProduct!.moq!;
      discountPriceCtrl.text = editableProduct!.discountedPrice!;
    }
  }

  void addEditProduct() async {
    if (nameTextCtrl.text.isEmpty ||
        moqCtrl.text.isEmpty ||
        priceCtrl.text.isEmpty ||
        discountPriceCtrl.text.isEmpty) {
      Helpers.toast("Please fill all required fields.");
      return;
    }
    showLoading();
    Map<String, String> jsonPrm = {
      "name": nameTextCtrl.text,
      "price": priceCtrl.text,
      "moq": moqCtrl.text,
      "discounted_price": discountPriceCtrl.text,
      "user_login_token": appController.user.value!.userToken!,
    };
    if (isEdit.isTrue) {
      jsonPrm['id'] = editableProduct!.id!;
      var res = await HttpService.instance.updateProduct(jsonPrm);
      dismissLoadingWidget();
      if (res != null) {
        Get.find<HomeController>().getProducts();
        Get.back();
        Helpers.toast(res['message']);
      }
    } else {
      var res = await HttpService.instance.addProduct(jsonPrm);
      dismissLoadingWidget();
      if (res != null) {
        Get.back();
        Helpers.toast(res['message']);
        Get.find<HomeController>().productsList.add(Product.fromJson(jsonPrm));
      }
    }
  }
}
