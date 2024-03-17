import 'package:test_app/views/screens/add_product/product_controller.dart';
import 'package:test_app/views/widgets/buttons.dart';
import 'package:test_app/views/widgets/textfields.dart';

import '../../../helper/app_export.dart';

class CreateEditProduct extends GetView<ProductController> {
  const CreateEditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                controller.isEdit.isFalse ? "Add Product" : "Edit Product")),
        body: Column(children: [
          Expanded(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                  controller: controller.nameTextCtrl,
                  hintText: "Product Name",
                  fieldName: "Name *",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.moqCtrl,
                  hintText: "Minimum Order Quantity",
                  fieldName: "Quantity *",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.priceCtrl,
                  hintText: "Price",
                  fieldName: "Price *",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: controller.discountPriceCtrl,
                  hintText: "Discount Price",
                  fieldName: "Discount Price *",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ])),
          AppButton(
              text: controller.isEdit.isFalse ? "Add" : 'Update',
              onPressed: () {
                controller.addEditProduct();
              }),
          const SizedBox(
            height: 30,
          ),
        ]));
  }
}
