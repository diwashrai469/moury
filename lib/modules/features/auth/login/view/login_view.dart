import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moury/theme/app_theme.dart';

import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/app_image.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../common/widgets/k_button.dart';
import '../../../../../common/widgets/k_textformfield.dart';
import '../view_models/login_view_models.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewModel());
    final formkey = GlobalKey<FormState>();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: AppDimens.secondaryPagePaading,
          child: Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImage.mouryText,
                      height: 40,
                      width: 150,
                    ),
                    elHeightSpan,
                    KTextFormField(
                      controller: userNameController,
                      hint: "Enter your username.",
                      keyboardType: TextInputType.emailAddress,
                      label: "Username",
                      validator: controller.userNameValidator,
                    ),
                    lHeightSpan,
                    KTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      validator: controller.passwordvalidator,
                      obscureText: true,
                      hint: "Enter your password.",
                      label: "Password",
                    ),
                    elHeightSpan,
                    Obx(
                      () => KButton(
                        size: ButtonSize.medium,
                        isBusy: controller.isLoading,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formkey.currentState!.validate()) {
                            controller.loginUser(userNameController.text,
                                passwordController.text);
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    lHeightSpan,
                    InkWell(
                      onTap: () => Get.toNamed(
                        "/signup",
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have a account yet?",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                              text: '  Create one',
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
                    const Text("OR"),
                    mHeightSpan,
                    KButton(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppImage.googleSvg,
                              height: 20,
                            ),
                            mWidthSpan,
                            const Text("Sign in with Google ")
                          ],
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
