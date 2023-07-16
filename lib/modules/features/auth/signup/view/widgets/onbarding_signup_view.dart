import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/app_image.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/common/widgets/k_textformfield.dart';

import '../../../../../../theme/app_theme.dart';
import '../../../register/view_models/register_view_models.dart';

AppBar appbar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: const IconThemeData(color: Colors.black),
);

class AskUserFullName extends StatelessWidget {
  const AskUserFullName({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final controller = Get.put(RegisterViewModel());
    TextEditingController fullnameController = TextEditingController();
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appbar,
      body: Form(
        key: formkey,
        child: Padding(
          padding: AppDimens.secondaryPagePaading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppImage.mouryText,
                  height: 40,
                  width: 150,
                ),
              ),
              elHeightSpan,
              Text("What is your name?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: AppDimens.headlineFontSizeOther)),
              lHeightSpan,
              KTextFormField(
                validator: controller.fullNameValidation,
                controller: fullnameController,
                label: " Fullname",
                hint: "Enter your full name",
              ),
              mHeightSpan,
              KButton(
                  child: const Text("Next"),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Get.toNamed(
                        '/ask-user-name',
                        arguments: {
                          'Full_name': fullnameController.text,
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class AskUserName extends StatefulWidget {
  const AskUserName({super.key});

  @override
  State<AskUserName> createState() => _AskUserNameState();
}

class _AskUserNameState extends State<AskUserName> {
  final controller = Get.put(RegisterViewModel());
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String fullName = args['Full_name'];
    TextEditingController usernameController = TextEditingController();

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appbar,
      body: Padding(
        padding: AppDimens.secondaryPagePaading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                AppImage.mouryText,
                height: 40,
                width: 150,
              ),
            ),
            elHeightSpan,
            Text(
              "Choose your unique username?",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: AppDimens.headlineFontSizeOther),
            ),
            lHeightSpan,
            KTextFormField(
              controller: usernameController,
              label: "Username",
              hint: "Enter your username",
            ),
            mHeightSpan,
            KButton(
                child: const Text("Next"),
                onPressed: () async {
                  var value = await controller.checkUsername(
                      username: usernameController.text);
                  if (value == true) {
                    Get.toNamed(
                      "/ask-user-email",
                      arguments: {
                        'username': usernameController.text,
                        'userFullname': fullName
                      },
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class AskUserEmail extends StatelessWidget {
  const AskUserEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final controller = Get.put(RegisterViewModel());
    final Map<String, dynamic> args = Get.arguments;
    final String username = args['username'];
    final String userFullName = args['userFullname'];
    TextEditingController useremailcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appbar,
      body: Form(
        key: formkey,
        child: Padding(
          padding: AppDimens.secondaryPagePaading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppImage.mouryText,
                  height: 40,
                  width: 150,
                ),
              ),
              elHeightSpan,
              Text(
                "Enter your email address?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: AppDimens.headlineFontSizeOther),
              ),
              lHeightSpan,
              KTextFormField(
                validator: controller.emailvalidator,
                controller: useremailcontroller,
                label: "Email",
                hint: "Enter your email",
              ),
              mHeightSpan,
              KButton(
                child: const Text("Next"),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    Get.toNamed("/ask-user-password", arguments: {
                      'useremail': useremailcontroller.text,
                      "username": username,
                      'userFullname': userFullName
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AskUserPassword extends StatelessWidget {
  const AskUserPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterViewModel());
    final formkey = GlobalKey<FormState>();
    final Map<String, dynamic> args = Get.arguments;
    final String useremail = args['useremail'];
    final String username = args['username'];
    final String userFullName = args['userFullname'];
    TextEditingController userPasswordcontroller = TextEditingController();
    TextEditingController userConfirmPasswordcontroller =
        TextEditingController();

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appbar,
      body: Form(
        key: formkey,
        child: Padding(
          padding: AppDimens.secondaryPagePaading,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppImage.mouryText,
                    height: 40,
                    width: 150,
                  ),
                ),
                elHeightSpan,
                Text(
                  "Enter a secure password?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: AppDimens.headlineFontSizeOther),
                ),
                lHeightSpan,
                KTextFormField(
                  validator: controller.passwordvalidator,
                  controller: userPasswordcontroller,
                  label: " Passowrd",
                  hint: "Enter your password",
                ),
                mHeightSpan,
                KTextFormField(
                  controller: userConfirmPasswordcontroller,
                  label: " Confirm passoword",
                  validator: controller.passwordvalidator,
                  hint: "Enter your confirm password",
                ),
                mHeightSpan,
                Obx(
                  () => KButton(
                    size: ButtonSize.medium,
                    isBusy: controller.isLoading,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.registerUser(
                            username: username,
                            email: useremail,
                            password: userPasswordcontroller.text,
                            confirmPassword: userConfirmPasswordcontroller.text,
                            fullName: userFullName);
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
