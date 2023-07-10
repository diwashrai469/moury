import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/modules/features/profile/single_user_profile/view_model/single_user_profile_view_model.dart';

class SingleUserProfileView extends StatelessWidget {
  const SingleUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;

    final String userId = args['userId'];
    final controller = Get.put(SingleUserProfileViewModel());
    return GetBuilder<SingleUserProfileViewModel>(
      initState: (state) async {
        await controller.getSingleUser(userId);
        await controller.checkFollow(userId);
      },
      builder: (controller) {
        final userData = controller.userResponseModel?.data?.first;

        return Scaffold(
          appBar: AppBar(
              title:
                  Text(controller.userResponseModel?.data?.first.name ?? '')),
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
                        mHeightSpan,
                        userData?.profilePicture?.isEmpty == true
                            ? CircleAvatar(
                                radius: 45,
                                child: Text(userData?.name?[0] ?? ''),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    userData?.profilePicture ?? ''),
                              ),
                        Text("Name: ${userData?.name ?? ''}"),
                        Text("Username:${userData?.username ?? ''}"),
                        Text("Level:${userData?.level.toString() ?? ''}"),
                        Text("Streak:${userData?.streak.toString() ?? '0'}"),
                        Text(
                            "Followers:${userData?.followers.toString() ?? '0'}"),
                        Text(
                            "Following:${userData?.following.toString() ?? '0'}"),
                        mHeightSpan,
                        controller.checkStatus(
                            controller.followResponseData?.status ?? '',
                            userId,
                            userData?.username),
                        if (controller.followResponseData?.status == "friends")
                          KButton(
                              child: const Text("Un-Follow"),
                              onPressed: () async {
                                await controller.unFollowUser(userId);
                                await controller.checkFollow(userId);
                              })
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
