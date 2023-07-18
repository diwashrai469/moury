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
                backgroundColor: secondaryColor,
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(MediaQuery.of(context).size.height / 5),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: avatarBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.more_vert),
                        ),
                      )
                    ],
                  ),
                ),
                body: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: AppDimens.mainPagePadding,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 6.2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: Colors.blueGrey,
                                    margin: const EdgeInsets.only(left: 25),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Followers",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: AppDimens
                                                        .buttonFontSizeMedium),
                                          ),
                                          sHeightSpan,
                                          Text(
                                              userData?.followers.toString() ??
                                                  "0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.blueGrey,
                                    margin: const EdgeInsets.only(right: 25),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Following",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: AppDimens
                                                        .buttonFontSizeMedium),
                                          ),
                                          sHeightSpan,
                                          Text(
                                            userData?.following.toString() ??
                                                '0',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              elHeightSpan,
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height / 3.6,
                              // ),
                              controller.checkStatus(
                                  controller.followResponseData?.status ?? '',
                                  userId,
                                  userData?.username,
                                  userData?.profilePicture),
                              sHeightSpan,
                              if (controller.followResponseData?.status ==
                                  "friends")
                                KButton(
                                  child: const Text("Un-Follow"),
                                  onPressed: () async {
                                    await controller.unFollowUser(userId);
                                    await controller.checkFollow(userId);
                                  },
                                )
                            ],
                          ),
                        ),
                      ),
              ),
              Positioned(
                top: 140,
                right: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius:
                        BorderRadius.circular(AppDimens.sboarderRadisCircular),
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                      ),
                      Text(
                        userData?.name ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: AppDimens.buttonFontSizeMedium,
                            ),
                      ),
                      xxsHeightSpan,
                      Text(
                        "@${userData?.username ?? ''}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: disabledColor),
                      ),
                      xxsHeightSpan,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: primaryColor,
                          ),
                          xxsWidthSpan,
                          Text("Level: ${userData?.level.toString() ?? ''}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 85,
                right: MediaQuery.of(context).size.width / 3,
                child: Hero(
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
                                imageUrl: userData?.profilePicture ?? ''),
                          ),
                          child: CircleAvatar(
                            radius: 53,
                            backgroundColor: Colors.grey.shade300,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userData?.profilePicture ?? ''),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
