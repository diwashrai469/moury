import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/splash/view_model/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashViewModel());
    return const Scaffold(
      body: Center(
        child: Text("Splash screen"),
      ),
    );
  }
}
