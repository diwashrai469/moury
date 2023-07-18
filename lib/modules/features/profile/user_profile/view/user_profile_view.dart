import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_dialog.dart';
import 'package:moury/common/widgets/k_photo_preview.dart';
import 'package:moury/core/services/local_storage.dart';
import 'package:moury/modules/features/profile/user_profile/view_models/user_profile_view_model.dart';
import 'package:moury/theme/app_theme.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileviewModel>(
      init: UserProfileviewModel(),
      builder: (controller) {
        final userConfigData = controller.userConfigData?.data;
        return Scaffold(
          backgroundColor: secondaryColor,
          body: SafeArea(
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: AppDimens.secondaryPagePaading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        lHeightSpan,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Text(
                                "Profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            AppDimens.headlineFontSizeOther),
                              ),
                            ),
                            PopupMenuButton<String>(
                              offset: const Offset(0, 40),
                              padding: const EdgeInsets.all(8),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              onSelected: (String option) {
                                if (option == 'Logout') {
                                  kDialogBox(
                                    context,
                                    heading: "Confirm!",
                                    message:
                                        "Are you sure you want to leave this group?",
                                    onKeyPressed: () async {
                                      LocalStorageService()
                                          .clear(LocalStorageKeys.accessToken);
                                      Get.offAllNamed('/login');
                                    },
                                  );
                                }
                                if (option == 'Edit') {
                                  Get.toNamed(
                                    '/edit-user-profile',
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 0),
                                    height: 23,
                                    value: 'Edit',
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          color: primaryColor,
                                          size: 15,
                                        ),
                                        xsWidthSpan,
                                        Text(
                                          'Edit',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 5),
                                    height: 23,
                                    value: 'Logout',
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout_rounded,
                                          color: primaryColor,
                                          size: 15,
                                        ),
                                        xsWidthSpan,
                                        Text(
                                          'Logout',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        mHeightSpan,
                        Center(
                          child: userConfigData?.profilePicture?.isEmpty ==
                                      true ||
                                  userConfigData?.profilePicture == null
                              ? CircleAvatar(
                                  radius: 50,
                                  child:
                                      Text(userConfigData?.username?[0] ?? ''),
                                )
                              : GestureDetector(
                                  onTap: () => Get.to(
                                    KPhotoPreviewView(
                                        imageUrl:
                                            userConfigData.profilePicture ??
                                                ''),
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        userConfigData!.profilePicture ??
                                            'N/a'),
                                  ),
                                ),
                        ),
                        mHeightSpan,
                        Text(userConfigData?.name ?? 'N/a'),
                        Text(
                          "@${userConfigData?.username ?? 'N/a'}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: disabledColor),
                        ),
                        sHeightSpan,
                        Text("Email: ${userConfigData?.email ?? 'N/a'}"),
                        sHeightSpan,
                        mHeightSpan,
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 78, 104, 117),
                              borderRadius: BorderRadius.circular(
                                  AppDimens.sboarderRadisCircular)),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Followers"),
                                  mHeightSpan,
                                  Text(userConfigData?.followers.toString() ??
                                      '0')
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Level"),
                                  mHeightSpan,
                                  Text(userConfigData?.level.toString() ?? '0')
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Streak"),
                                  mHeightSpan,
                                  Text(userConfigData?.streak.toString() ?? '0')
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Buzz"),
                                  mHeightSpan,
                                  Text(userConfigData?.buzzs.toString() ?? '0')
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
