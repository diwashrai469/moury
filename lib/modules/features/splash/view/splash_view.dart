import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_image.dart';
import 'package:moury/modules/features/splash/view_model/splash_view_model.dart';
import 'package:moury/theme/app_theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late Animation<double> logoAnimation;
  late AnimationController logoController;

  @override
  void initState() {
    logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    logoAnimation = Tween(begin: 0.35, end: 0.5).animate(
      CurvedAnimation(
        parent: logoController,
        curve: Curves.elasticOut,
      ),
    );

    logoController.forward().then((value) => Get.put(SplashViewModel()));
    super.initState();
  }

  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: logoAnimation,
          builder: (context, child) {
            return SvgPicture.asset(
              AppImage.splashImage,
              width: MediaQuery.of(context).size.width * logoAnimation.value,
            );
          },
        ),
      ),
    );
  }
}
