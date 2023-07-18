import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/modules/features/community_collection/my_community/model_view/my_community_view.model.dart';

import '../../../../../../common/constant/app_dimens.dart';
import '../../../../../../theme/app_theme.dart';

class CreateCommunityView extends StatelessWidget {
  const CreateCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final formkey = GlobalKey<FormState>();

    return GetBuilder<MyCommunityViewModel>(builder: (controller) {
      return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Create community",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: AppDimens.titleFontSize, color: Colors.white),
          ),
          backgroundColor: secondaryColor,
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: AppDimens.mainPagePadding,
            child: Column(
              children: [
                KTextFormField(
                  controller: nameController,
                  validator: (name) {
                    if (name?.isEmpty == true) {
                      return "Name is required";
                    }
                    return null;
                  },
                  label: "Name",
                  hint: "Enter community name.",
                ),
                mHeightSpan,
                KTextFormField(
                  controller: descriptionController,
                  label: "Description",
                  validator: (description) {
                    if (description?.isEmpty == true) {
                      return "Description is required";
                    }
                    return null;
                  },
                  hint: "Enter community description.",
                ),
                lHeightSpan,
                KButton(
                    child: const Text("Create"),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formkey.currentState!.validate()) {
                        controller.createCommunity(
                            nameController.text, descriptionController.text);
                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
