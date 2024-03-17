import 'package:flutter/gestures.dart';
import 'package:test_app/views/widgets/buttons.dart';
import 'package:test_app/views/widgets/textfields.dart';

import '../../../helper/app_export.dart';
import '../../../helper/theme.dart';
import 'auth_controller.dart';
import 'login_view.dart';

class SignUpView extends GetView<AuthController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    controller: controller.nameCtrl,
                    fieldName: "Name *",
                    hintText: "Name",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: controller.emailCtrl,
                    fieldName: "Email *",
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: controller.mobileCtrl,
                    fieldName: "Mobile *",
                    hintText: "Mobile",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: controller.passwordCtrl,
                    fieldName: "Password *",
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        // onTap: () => Get.to(() => LogInView()),
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyle.linkText,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                          text: "Already have  an account? ",
                          children: <InlineSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: 'Log In',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ])),
                    ],
                  ),
                ],
              ),
            ),
            AppButton(
                text: "Sign Up",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.register();
                }),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
