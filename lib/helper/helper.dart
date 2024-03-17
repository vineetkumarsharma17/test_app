import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helpers {
  static toast(String msg) {
    return Get.rawSnackbar(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        // title: "msg",
        message: msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 225, 81, 24));
    // return Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: primaryDark,
    //     textColor: light,
    //     fontSize: 16.0);
  }

  static String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'
        .split('.')[0]
        .substring(2)
        .padLeft(4, '0');
  }

  static String get getTimeStamp =>
      DateTime.now().microsecondsSinceEpoch.toString();
}
