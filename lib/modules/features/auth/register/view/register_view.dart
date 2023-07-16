import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../common/widgets/k_button.dart';
import '../../../../../common/widgets/k_textformfield.dart';
import '../view_models/register_view_models.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewModel());
    final formkey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullnameController = TextEditingController();
    final usernameController = TextEditingController();
    final confirmpasswordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: AppDimens.secondaryPagePaading,
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
                      keyboardType: TextInputType.visiblePassword,
                      controller: fullnameController,
                      validator: controller.fullNameValidation,
                      hint: "Enter your fullname.",
                      label: "Full Name",
                    ),
                    lHeightSpan,
                    KTextFormField(
                      controller: usernameController,
                      hint: "Enter your username.",
                      keyboardType: TextInputType.emailAddress,
                      label: "Username",
                      validator: controller.userNameValidator,
                    ),
                    lHeightSpan,
                    KTextFormField(
                      controller: emailController,
                      hint: "Enter your email.",
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      validator: controller.emailvalidator,
                    ),
                    lHeightSpan,
                    KTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      validator: controller.passwordvalidator,
                      hint: "Enter your password.",
                      label: "Password",
                    ),
                    lHeightSpan,
                    KTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: confirmpasswordController,
                      validator: controller.passwordvalidator,
                      hint: "Enter your confirm password.",
                      label: "Confirm password",
                    ),
                    elHeightSpan,
                    Obx(
                      () => KButton(
                        size: ButtonSize.medium,
                        isBusy: controller.isLoading,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.registerUser(
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmpasswordController.text,
                                fullName: fullnameController.text);
                          }
                        },
                        child: const Text("Register"),
                      ),
                    ),
                    lHeightSpan,
                    InkWell(
                      onTap: () => Get.toNamed(
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
                    )
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
