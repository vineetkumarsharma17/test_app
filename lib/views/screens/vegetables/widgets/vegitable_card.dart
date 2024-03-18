import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/helper/theme.dart';
import 'package:test_app/models/vegetable.dart';

import '../vegetable_detail_view.dart';

class VegetableCards extends StatelessWidget {
  const VegetableCards({super.key, required this.vegetable});
  final Vegetable vegetable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => VegetableDetailView(vegetable));
      },
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: Get.width,
        child: Row(
          children: [
            Expanded(
                child: Image.asset(
              vegetable.image!,
              height: double.infinity,
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  vegetable.name!,
                  style: AppTextStyle.heading,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(TextSpan(
                    text: vegetable.price,
                    style: AppTextStyle.h2.copyWith(fontSize: 16),
                    children: <InlineSpan>[
                      TextSpan(
                          text: ' \u20AC /piece',
                          style: AppTextStyle.text.copyWith(
                              color: AppColors.lightGrey, fontSize: 16))
                    ])),
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
            ))
          ],
        ),
      ),
    );
  }
}
