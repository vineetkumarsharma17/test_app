import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helper/theme.dart';

class AppShimmer extends StatelessWidget {
  final itemCount;
  const AppShimmer({Key? key, this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.primary.withOpacity(.5),
        // baseColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.grey,
        child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: itemCount,
            shrinkWrap: true, //    <-- Set this to true
            physics: ScrollPhysics(),
            itemBuilder: (content, index) {
              return Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100,
                            height: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: Get.width * .3,
                            height: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
