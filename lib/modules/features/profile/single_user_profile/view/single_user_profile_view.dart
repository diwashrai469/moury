import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/modules/features/profile/single_user_profile/view_model/single_user_profile_view_model.dart';
import 'package:moury/theme/app_theme.dart';

import '../../../../../common/widgets/k_photo_preview.dart';

class SingleUserProfileView extends StatelessWidget {
  const SingleUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;

    final String userId = args['userId'];

    return GetBuilder<SingleUserProfileViewModel>(
      init: SingleUserProfileViewModel(userId: userId),
      builder: (controller) {
        final userData = controller.userResponseModel?.data?.first;

        return Material(
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                body: Padding(
                  padding: AppDimens.mainPagePadding,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: userId,
                          child: userData?.profilePicture?.isEmpty == true ||
                                  userData?.profilePicture == null
                              ? CircleAvatar(
                                  radius: 53,
                                  backgroundColor: Colors.grey.shade300,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 50,
                                    child: Text(
                                      userData?.name?[0] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => Get.to(
                                    KPhotoPreviewView(
                                        imageUrl:
                                            userData?.profilePicture ?? ''),
                                  ),
                                  child: CircleAvatar(
                                    radius: 53,
                                    backgroundColor: Colors.grey.shade300,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          userData?.profilePicture ?? ''),
                                    ),
                                  ),
                                ),
                        ),
                        xxsHeightSpan,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userData?.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: AppDimens.buttonFontSizeMedium,
                                  ),
                            ),
                            sWidthSpan,
                            Chip(
                                padding: EdgeInsets.zero,
                                backgroundColor: const Color(0xFF473F2E),
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.local_fire_department,
                                      color: errorColor,
                                    ),
                                    xxsWidthSpan,
                                    Text(
                                      userData?.streak.toString() ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Text(
                          "@${userData?.username ?? ''}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: disabledColor),
                        ),
                        mHeightSpan,
                        Row(
                          children: [
                            Expanded(
                              child: controller.checkStatus(
                                  controller.checkFriendResponseModel?.status ??
                                      '',
                                  userId,
                                  userData?.username,
                                  userData?.profilePicture),
                            ),
                            if (controller.checkFriendResponseModel
                                    ?.friendshipStatus ==
                                "to_be_accepted")
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: KButton(
                                    isBusy: controller.isLoading,
                                    child: const Text("Delete request"),
                                    onPressed: () async {
                                      await controller.rejectRequest(userId);
                                      await controller.checkIsFriend(userId);
                                    },
                                  ),
                                ),
                              ),
                            if (controller
                                    .checkFriendResponseModel?.areFriends ==
                                true)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: KButton(
                                    isBusy: controller.isLoading,
                                    child: const Text("Un-friend"),
                                    onPressed: () async {
                                      await controller.rejectRequest(userId);
                                      await controller.checkIsFriend(userId);
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                        // mHeightSpan,
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: KListtile(
                        //       text: controller
                        //               .myFriendsResponseModel?.data?.length
                        //               .toString() ??
                        //           '0',
                        //     ))
                        //   ],
                        // ),
                        elHeightSpan,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
