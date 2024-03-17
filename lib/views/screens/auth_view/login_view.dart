import 'package:flutter/gestures.dart';
import 'package:test_app/views/screens/auth_view/signup_view.dart';
import 'package:test_app/views/widgets/buttons.dart';
import 'package:test_app/views/widgets/textfields.dart';

import '../../../helper/app_export.dart';
import '../../../helper/theme.dart';
import 'auth_controller.dart';

class LogInView extends GetView<AuthController> {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Log In")),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  AppTextField(
                    controller: controller.emailCtrl,
                    fieldName: "Email *",
                    hintText: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: controller.passwordCtrl,
                    fieldName: "Password *",
                    hintText: "Password",
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                          text: "Don't have  an account? ",
                          children: <InlineSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => SignUpView()),
                              text: 'Sign Up',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ])),
                    ],
                  ),
                ],
              ),
            ),
            AppButton(text: "Log In", onPressed: () => controller.logIn()),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
