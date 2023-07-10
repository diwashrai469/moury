import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/core/services/local_storage.dart';
import 'package:moury/modules/features/profile/user_profile/view_models/user_profile_view_model.dart';
import '../../../../../common/widgets/k_button.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileviewModel());

    return GetBuilder<UserProfileviewModel>(initState: (state) async {
      await controller.getUserConfig();
    }, builder: (controller) {
      final userConfigData = controller.userConfigData?.data;
      return Scaffold(
        appBar: AppBar(title: const Text("Profile"), actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
                onTap: () => Get.toNamed(
                      '/edit-user-profile',
                    ),
                child: const Icon(Icons.edit)),
          )
        ]),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: AppDimens.mainPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userConfigData?.profilePicture?.isEmpty == true ||
                            userConfigData?.profilePicture == null
                        ? CircleAvatar(
                            radius: 45,
                            child: Text(userConfigData?.username?[0] ?? ''),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                userConfigData!.profilePicture ?? 'N/a'),
                          ),
                    mHeightSpan,
                    Text("Name: ${userConfigData?.name ?? 'N/a'}"),
                    sHeightSpan,
                    Text("Username: ${userConfigData?.username ?? 'N/a'}"),
                    sHeightSpan,
                    Text("Email: ${userConfigData?.email ?? 'N/a'}"),
                    elHeightSpan,
                    KButton(
                        child: const Text("logout"),
                        onPressed: () {
                          LocalStorageService()
                              .clear(LocalStorageKeys.accessToken);
                          Get.offAndToNamed('/login');
                        }),
                  ],
                ),
              ),
      );
    });
  }
}
