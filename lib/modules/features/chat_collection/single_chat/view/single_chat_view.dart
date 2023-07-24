import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/modules/features/chat_collection/single_chat/view/widgets/single_chat_message_box.dart';
import 'package:moury/modules/features/chat_collection/single_chat/view_model/single_chat_view_model.dart';
import '../../../../../common/widgets/k_container_for_bottom_sheet.dart';
import '../../../../../common/widgets/k_listile.dart';
import '../../../../../theme/app_theme.dart';

class SingleChatView extends StatefulWidget {
  const SingleChatView({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleChatView> createState() => _SingleChatViewState();
}

class _SingleChatViewState extends State<SingleChatView> {
  final chatViewModel = Get.put(SingleChatViewModel());
  final Map<String, dynamic> args = Get.arguments;
  late final String userId;
  late final String name;
  late final String? userImage;
  @override
  void initState() {
    userId = args['userId'];
    name = args['username'];
    userImage = args['userImage'];
    chatViewModel.clearChatList();
    chatViewModel.getPrivateChats(userId);
    chatViewModel.getPrivateChatList(userId);
    super.initState();
  }

  @override
  void dispose() {
    chatViewModel.chatSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: ListTile(
            horizontalTitleGap: -3,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            leading: userImage?.isEmpty == true
                ? CircleAvatar(
                    backgroundColor: avatarBackgroundColor,
                    radius: AppDimens.sssCircleAvatarRadius,
                    child: Text(
                      name[0],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: avatarBackgroundColor,
                    radius: AppDimens.sssCircleAvatarRadius,
                    backgroundImage: NetworkImage(userImage ?? '')),
            title: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: AppDimens.nameFontSize),
            ),
            subtitle: Text(
              "online",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppDimens.subsubFontSize,
                    color: disabledColor,
                  ),
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          )),
      body: GetBuilder<SingleChatViewModel>(
        builder: (controller) {
          return Padding(
            padding: AppDimens.mainPagePadding,
            child: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: controller.chatList.length,
                      itemBuilder: (context, index) {
                        final chatItem = controller.chatList[index];

                        String name = '';
                        String message = '';
                        String userImage = '';

                        name = chatItem.senderDetails?.senderUsername ?? '';
                        message = chatItem.message ?? '';
                        userImage =
                            chatItem.senderDetails?.senderProfilePicture ?? '';

                        return ListTile(
                          contentPadding:
                              chatItem.senderId != chatViewModel.userId
                                  ? const EdgeInsets.only(right: 50)
                                  : const EdgeInsets.only(left: 50),
                          visualDensity: const VisualDensity(vertical: -3),
                          horizontalTitleGap: 2,
                          leading: chatItem.senderId != chatViewModel.userId
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: chatItem.senderId !=
                                          (index + 1 <
                                                  controller.chatList.length
                                              ? controller
                                                  .chatList[index + 1].senderId
                                              : 0)
                                      ? InkWell(
                                          onTap: () => kshowBottomSheet(
                                              chatItem.senderId ?? ""),
                                          child: userImage.isEmpty
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      avatarBackgroundColor,
                                                  radius: AppDimens
                                                      .ssCircleAvatarRadius,
                                                  child: Text(
                                                    name[0],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: AppDimens
                                                                .nameFontSize,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      avatarBackgroundColor,
                                                  radius: AppDimens
                                                      .ssCircleAvatarRadius,
                                                  backgroundImage:
                                                      NetworkImage(userImage),
                                                ),
                                        )
                                      : null)
                              : null,
                          subtitle: Align(
                            alignment: chatItem.senderId == chatViewModel.userId
                                ? Alignment.topRight
                                : Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: chatItem.senderId ==
                                            chatViewModel.userId
                                        ? BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            bottomRight: chatItem.senderId !=
                                                    (index + 1 <
                                                            controller
                                                                .chatList.length
                                                        ? controller
                                                            .chatList[index + 1]
                                                            .senderId
                                                        : 0)
                                                ? Radius.zero
                                                : const Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            topLeft: chatItem.senderId !=
                                                    (index + 1 <
                                                            controller
                                                                .chatList.length
                                                        ? controller
                                                            .chatList[index + 1]
                                                            .senderId
                                                        : 0)
                                                ? Radius.zero
                                                : const Radius.circular(10),
                                            topRight: const Radius.circular(10),
                                            bottomLeft:
                                                const Radius.circular(10),
                                            bottomRight:
                                                const Radius.circular(10)),
                                    color: chatItem.senderId ==
                                            chatViewModel.userId
                                        ? const Color.fromARGB(255, 190, 116, 3)
                                        : const Color(0xFF474747),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    chatViewModel.isSeen
                        ? (userImage?.isEmpty == true || userImage == null)
                            ? CircleAvatar(
                                backgroundColor: avatarBackgroundColor,
                                radius: 8,
                                child: Text(
                                  name[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: AppDimens.nameFontSize,
                                          color: Colors.white),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: avatarBackgroundColor,
                                radius: 8,
                                backgroundImage: NetworkImage(userImage ?? ''),
                              )
                        : CircleAvatar(
                            backgroundColor: secondaryColor,
                            radius: 8,
                            child: Text(
                              name[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: AppDimens.nameFontSize,
                                      color: secondaryColor),
                            ),
                          ),
                  ],
                ),
                sHeightSpan,
                SingleChatMessageBox(userId: userId, controller: controller),
                mHeightSpan,
              ],
            ),
          );
        },
      ),
    );
  }
}

void kshowBottomSheet(String userId) {
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
              text: "View Profile",
              icon: CupertinoIcons.person_alt_circle,
              onKeyPressed: () {
                Get.back();
                Get.toNamed("/single-user-profile",
                    arguments: {'userId': userId});
              },
            ),
          ),
        ],
      ),
    ),
  );
}
