import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_app/helper/theme.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/views/screens/home_view/home_controller.dart';
import 'package:test_app/views/widgets/show_loading.dart';

import '../../add_product/add_product_view.dart';
import '../../add_product/product_binding.dart';

class ProductWidget extends GetWidget<HomeController> {
  const ProductWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          // contentPadding: EdgeInsets.zero,
          title: Text(product.name ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    if (product.id != null) {
                      Get.to(() => const CreateEditProduct(),
                          binding: ProductBindings(), arguments: product);
                    } else {
                      Get.find<HomeController>().getProducts(true);
                    }
                  },
                  child: const Icon(Icons.edit)),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    if (product.id != null) {
                      controller.deleteProduct(product.id!);
                    } else {
                      controller.getProducts(true);
                    }
                  },
                  child: Icon(Icons.delete)),
            ],
          ),

          subtitle: Column(
            children: [
              Row(
                children: [
                  Text("Price:"),
                  Text(product.price!),
                ],
              ),
              Row(
                children: [
                  Text("Discount price:"),
                  Text(product.discountedPrice!),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
            height: 5,
            child: Divider(
              color: AppColors.grey,
            ))
      ],
    );
  }
}
