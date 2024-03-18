import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_app/models/vegetable.dart';

import '../../../helper/theme.dart';

class VegetableDetailView extends GetView {
  const VegetableDetailView(this.vegetable, {super.key});
  final Vegetable vegetable;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: Get.height,
        child: Stack(children: [
          Image.asset(
            vegetable.image!,
            width: Get.width,
            height: Get.height * .35,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(
              top: Get.height * .35 - 20,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vegetable.name!,
                  style: AppTextStyle.h2.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(TextSpan(
                    text: vegetable.price,
                    style: AppTextStyle.h2.copyWith(fontSize: 20),
                    children: <InlineSpan>[
                      TextSpan(
                          text: ' \u20AC /piece',
                          style: AppTextStyle.text.copyWith(
                              color: AppColors.lightGrey, fontSize: 16))
                    ])),
                Text(
                  '~ ${vegetable.weight!} /piece',
                  style: AppTextStyle.text.copyWith(color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Spain',
                  style: AppTextStyle.h2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  vegetable.details!,
                  style: AppTextStyle.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightGreyText,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColors.grey,
                        size: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightGreyText,
                          ),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
