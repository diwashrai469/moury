import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/constant/app_dimens.dart';
import '../../../../common/constant/ui_helpers.dart';
import '../../../../common/widgets/k_button.dart';
import '../../../../common/widgets/k_textformfield.dart';
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
      body: SafeArea(
        child: Padding(
          padding: AppDimens.mainPagePadding,
          child: Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "moury",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: const Color.fromRGBO(238, 146, 9, 1),
                          ),
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
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formkey.currentState!.validate()) {
                            await controller.loginUser(
                                userNameController.text, passwordController.text);
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    lHeightSpan,
                    InkWell(
                      onTap: () => Get.toNamed(
                        "/register",
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
                              "asset/googlesvg.svg",
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
