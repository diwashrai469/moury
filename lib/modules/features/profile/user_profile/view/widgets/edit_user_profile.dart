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

    void kshowBottomSheet() {
      Get.bottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: AppDimens.globalCircularRadius,
          ),
        ),
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
                    Get.back();
                    controller.pickImage(
                        ImageSource.gallery, nameController.text);
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0, top: 20),
              child: InkWell(
                onTap: () async {
                  if (controller.uploadedImageUrl.isNotEmpty) {
                    await controller.editUser(controller.uploadedImageUrl,
                        username: nameController.text);
                  }

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
        body: Padding(
          padding: AppDimens.mainPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          NetworkImage(userConfigData!.profilePicture ?? 'N/a'),
                    ),
                  ),
                  Positioned(
                      bottom: 2,
                      right: 0,
                      child: InkWell(
                        onTap: () => kshowBottomSheet(),
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: controller.isLoading
                                ? const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.black,
                                    size: 19,
                                  )),
                      ))
                ],
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
