import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/widgets/k_button.dart';

import '../../../../../common/constant/app_image.dart';
import '../../../../../common/constant/ui_helpers.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDimens.mainPagePadding,
        child: Column(
          children: [
            elHeightSpan,
            lHeightSpan,
            SvgPicture.asset(
              AppImage.mouryText,
              height: 40,
              width: 150,
            ),
            Lottie.asset(
              AppImage.onboardingImage,
            ),
            Expanded(
                child: Text(
              textAlign: TextAlign.center,
              "Chat Beyond Boundaries, Connect with the World",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.headlineFontSizeOther,
                  ),
            )),
            KButton(
              child: const Text("Get started"),
              onPressed: () {
                Get.toNamed('/ask-user-fullname');
              },
            ),
            mHeightSpan,
            InkWell(
              onTap: () => Get.offAndToNamed(
                "/login",
              ),
              child: RichText(
                text: TextSpan(
                  text: "Already have a account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: '  Login',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ),
            mHeightSpan,
          ],
        ),
      ),
    );
  }
}
