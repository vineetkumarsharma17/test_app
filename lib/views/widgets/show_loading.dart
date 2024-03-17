import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/theme.dart';

showLoading([String text = ""]) {
  // TODO : BETTER DESIGN
  Get.dialog(
    Dialog(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: UnconstrainedBox(
          child: Column(
            children: [
              Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80)),
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    'assets/icons/loading.gif',
                    width: 80,
                  )),
              Text(
                text,
                style: AppTextStyle.text.copyWith(color: Colors.white),
              ),
            ],
          ),
        )),
  );
  return;
}

dismissLoadingWidget() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

Widget loadingWidget() {
  return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100)),
      child: Image.asset(
        'assets/icons/loading.gif',
        width: 150,
      ));
}
