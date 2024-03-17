import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SplashView extends GetView {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(child: Image.asset('assets/icons/logo.png')),
    );
  }
}
