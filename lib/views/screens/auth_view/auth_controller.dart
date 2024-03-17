import 'dart:convert';
import 'dart:developer';

import 'package:test_app/helper/helper.dart';
import 'package:test_app/services/http_service.dart';
import 'package:test_app/services/local_storage.dart';
import 'package:test_app/views/widgets/show_loading.dart';

import '../../../helper/app_export.dart';

class AuthController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void logIn() async {
    if (emailCtrl.text.isEmpty) {
      Helpers.toast("Username can't be empty.");
      return;
    }
    if (passwordCtrl.text.isEmpty) {
      Helpers.toast("Password can't be empty.");
      return;
    }
    try {
      showLoading();
      var data = {
        // "email": "user@innovins.com",
        "email": emailCtrl.text.trim(),
        // "password": "123456"
        "password": passwordCtrl.text.trim()
      };
      var user = await HttpService.instance.login(data);
      if (user != null) {
        dismissLoadingWidget();
        Helpers.toast("Success.");
        StorageService.setCredential = data;
        appController.user(user);
      }
    } catch (e) {
      dismissLoadingWidget();
    } finally {
      dismissLoadingWidget();
    }
  }

  void register() async {
    if (emailCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty ||
        nameCtrl.text.isEmpty ||
        mobileCtrl.text.isEmpty) {
      Helpers.toast("All fields are required.");
      return;
    }

    try {
      showLoading();
      var data = {
        "email": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
        "name": nameCtrl.text.trim(),
        "mobile": mobileCtrl.text.trim()
      };
      log("prm $data");
      var user = await HttpService.instance.register(data);
      log("message $user");
      if (user != null) {
        // log(appController.user.value!.toJson().toString());
        log(user.toJson().toString());
        dismissLoadingWidget();
        Helpers.toast("Success.");
        data.remove('mobile');
        data.remove('name');
        StorageService.setCredential = data;
        appController.user(user);
      }
    } catch (e) {
      log(e.toString());
      dismissLoadingWidget();
    } finally {
      dismissLoadingWidget();
    }
  }
}
