import 'package:flutter/material.dart';
import 'package:test_app/helper/app_export.dart';
import 'package:test_app/helper/theme.dart';
import 'package:test_app/views/screens/vegetables/vegetable_bindings.dart';
import 'package:test_app/views/widgets/buttons.dart';

import '../screens/vegetables/vegitables_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 44,
              child: Icon(Icons.person),
            ),
            ListTile(
              leading: const Text(
                "Name:",
                style: AppTextStyle.h2,
              ),
              title: Text(appController.user.value!.name!),
            ),
            ListTile(
              leading: const Text(
                "Mobile:",
                style: AppTextStyle.h2,
              ),
              title: Text(appController.user.value!.mobile!),
            ),
            ListTile(
              leading: const Text(
                "Email:",
                style: AppTextStyle.h2,
              ),
              title: Text(appController.user.value!.email!),
            ),
            Spacer(),
            AppButton(
                text: "Vegetables",
                onPressed: () {
                  Get.back();
                  Get.to(() => const VegetablesView(),
                      binding: VegetableBinding());
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
