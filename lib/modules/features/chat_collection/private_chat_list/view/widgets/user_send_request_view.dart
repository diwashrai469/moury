import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/constant/app_dimens.dart';
import '../../../../../../common/constant/ui_helpers.dart';
import '../../../../../../theme/app_theme.dart';
import '../../view_model/private_chat_view_model.dart';

class UserSendRequestView extends StatelessWidget {
  const UserSendRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: GetBuilder<PrivateChatViewModel>(
          init: PrivateChatViewModel(),
          builder: (controller) {
            return Padding(
              padding: AppDimens.mainPagePadding,
              child: controller.getRequestResponseModel?.data?.isEmpty == true
                  ? const Center(
                      child: Text("No any request"),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mHeightSpan,
                        Expanded(
                            child: GridView.builder(
                                itemCount: controller
                                    .getRequestResponseModel?.data?.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 20.0),
                                itemBuilder: (BuildContext context, int index) {
                                  final userData = controller
                                      .getRequestResponseModel?.data?[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        '/single-user-profile',
                                        arguments: {
                                          'userId': userData?.receiverId?.sId,
                                        },
                                      );
                                    },
                                    child: Card(
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            userData?.receiverId
                                                            ?.profilePicture ==
                                                        null ||
                                                    userData
                                                            ?.receiverId
                                                            ?.profilePicture
                                                            ?.isEmpty ==
                                                        true
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        avatarBackgroundColor,
                                                    radius: AppDimens
                                                        .elCircleAvatarRadius,
                                                    child: Text(
                                                      userData?.receiverId
                                                              ?.name?[0] ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: AppDimens
                                                                  .nameFontSize),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        avatarBackgroundColor,
                                                    radius: AppDimens
                                                        .elCircleAvatarRadius,
                                                    backgroundImage:
                                                        NetworkImage(userData
                                                                ?.receiverId
                                                                ?.profilePicture ??
                                                            ''),
                                                  ),
                                            Text(
                                                userData?.receiverId?.name ??
                                                    'N/a',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            sHeightSpan,
                                            Text(
                                                "@${userData?.receiverId?.name ?? 'N/a'}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontSize: AppDimens
                                                            .subsubFontSize)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
            );
          }),
    );
  }
}
