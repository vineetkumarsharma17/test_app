import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/controller/app_controller.dart';
import 'package:test_app/helper/theme.dart';
import 'package:test_app/views/screens/splash_view/splash_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashView(),
      initialBinding: AppInitialBinding(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
