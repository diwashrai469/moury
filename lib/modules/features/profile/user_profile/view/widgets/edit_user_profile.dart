import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_container_for_bottom_sheet.dart';
import 'package:moury/common/widgets/k_listile.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/modules/features/profile/user_profile/view_models/user_profile_view_model.dart';

class EditUserProfileView extends StatefulWidget {
  const EditUserProfileView({Key? key}) : super(key: key);

  @override
  State<EditUserProfileView> createState() => _EditUserProfileViewState();
}

class _EditUserProfileViewState extends State<EditUserProfileView> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileviewModel());

    void showBottomSheet() {
      Get.bottomSheet(
        backgroundColor: Colors.white,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              mHeightSpan,
              kContainerForBottomSheet(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: KListtile(
                  text: "Camera",
                  icon: Icons.camera_alt_rounded,
                  onKeyPressed: () {
                    controller.pickImage(
                        ImageSource.camera, nameController.text);
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: KListtile(
                  text: "Gallery",
                  icon: Icons.image,
                  onKeyPressed: () {
                    controller.pickImage(
                        ImageSource.gallery, nameController.text);
                    Get.back();
                  },
                ),
              )
            ],
          ),
        ),
      );
    }


    return GetBuilder<UserProfileviewModel>(initState: (state) async {
      await controller.getUserConfig();
    }, builder: (controller) {
      final userConfigData = controller.userConfigData?.data;
      nameController.text = userConfigData?.name ?? '';

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit profile",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0, top: 20),
              child: InkWell(
                onTap: () async {
                  await controller.editUser(controller.uploadedImageUrl,
                      username: nameController.text);
                  await controller.getUserConfig();
                  Get.back();
                },
                child: Text(
                  "Update",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: AppDimens.mainPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showBottomSheet();
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            userConfigData!.profilePicture ?? 'N/a'),
                      ),
                    ),
                    mHeightSpan,
                    KTextFormField(
                      label: "Name",
                      controller: nameController,
                      hint: "Enter your name",
                    ),
                    mHeightSpan,
                  ],
                ),
              ),
      );
    });
  }
}
