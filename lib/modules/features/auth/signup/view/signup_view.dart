import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/theme/app_theme.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KButton(
              child: const Text("Get started"),
              onPressed: () {
                Get.toNamed('/ask-user-fullname');
              },
            )
          ],
        ),
      ),
    );
  }
}
