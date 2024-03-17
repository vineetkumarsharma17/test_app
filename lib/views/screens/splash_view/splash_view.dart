import '../../../helper/app_export.dart';

class SplashView extends GetView<AppController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/icons/logo.png',
        height: 200,
      )),
    );
  }
}
