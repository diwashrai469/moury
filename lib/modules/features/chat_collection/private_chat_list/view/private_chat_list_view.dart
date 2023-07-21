import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/date_time.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_chat_simmer_effect.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/modules/features/chat_collection/private_chat_list/view/widgets/my_friend_list_view.dart';
import 'package:moury/theme/app_theme.dart';
import '../view_model/private_chat_view_model.dart';

class PrivateChatListView extends StatelessWidget {
  const PrivateChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PrivateChatViewModel(),
    );
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PrivateChatViewModel>(
          initState: (state) {
            controller.getPrivateChatList();
          },
          builder: (controller) {
            return Padding(
              padding: AppDimens.mainPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mHeightSpan,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Friends & chats",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: AppDimens.headlineFontSizeOther),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const MyFriendListView());
                          },
                          child: const Icon(
                            CupertinoIcons.person_2_square_stack,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                  mHeightSpan,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: KTextFormField(
                      onChanged: controller.onChangedFilter,
                      hint: "   Search friends",
                      suffixIcon: const Icon(
                        CupertinoIcons.search,
                        color: disabledColor,
                      ),
                    ),
                  ),
                  sHeightSpan,
                  controller.isLoading
                      ? const Expanded(child: KChatSimmerEffect())
                      : controller.chatList.isEmpty == true
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "No any message.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: AppDimens.subFontSize,
                                          color: disabledColor),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.chatList.length,
                                itemBuilder: (context, index) {
                                  final chatItem = controller.chatList[index];
                                  var dateTime = ShowDateAndTimeInAgo()
                                      .convertToTimeAgo(chatItem.time!.toInt());
                                  String name = '';
                                  String message = '';
                                  String nextPartyId = '';
                                  String userImage = '';
                                  bool? seenActual = false;
                                  bool? isSeen = false;

                                  if (chatItem.senderId == controller.userId) {
                                    name = chatItem.receiverDetails
                                            ?.receiverUsername ??
                                        '';
                                    seenActual = chatItem.seen_actual;
                                    isSeen = chatItem.seen;

                                    message = "You: ${chatItem.message ?? ''}";
                                    nextPartyId = chatItem.receiverId ?? '';
                                    userImage = chatItem.receiverDetails
                                            ?.receiverProfilePicture ??
                                        '';
                                  } else {
                                    name = chatItem
                                            .senderDetails?.senderUsername ??
                                        '';
                                    seenActual = chatItem.seen_actual;
                                    isSeen = chatItem.seen;

                                    message = chatItem.message ?? '';

                                    nextPartyId = chatItem.senderId ?? '';
                                    userImage = chatItem.senderDetails
                                            ?.senderProfilePicture ??
                                        '';
                                  }

                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed('/single-chat', arguments: {
                                        'userId': nextPartyId,
                                        'username': name,
                                        "userImage": userImage
                                      });

                                      // controller.updateDocument(
                                      //     nextPartyId, controller.userId ?? '');
                                    },
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(5),
                                      leading: userImage.isEmpty
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  avatarBackgroundColor,
                                              radius: AppDimens
                                                  .elCircleAvatarRadius,
                                              child: Text(
                                                name[0],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: AppDimens
                                                            .nameFontSize),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: AppDimens
                                                  .elCircleAvatarRadius,
                                              backgroundImage:
                                                  NetworkImage(userImage),
                                            ),
                                      subtitle: Text(
                                        overflow: TextOverflow.ellipsis,
                                        message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: seenActual == true
                                                    ? disabledColor
                                                    : Colors.white,
                                                fontSize: AppDimens.subFontSize,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                            name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize:
                                                        AppDimens.nameFontSize),
                                          ),
                                          sWidthSpan,
                                          if (seenActual == false)
                                            const CircleAvatar(
                                              radius: 4,
                                              backgroundColor: primaryColor,
                                            )
                                        ],
                                      ),
                                      trailing: Column(
                                        children: [
                                          (isSeen == true &&
                                                  chatItem.senderId ==
                                                      controller.userId)
                                              ? userImage.isEmpty
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              userImage),
                                                      radius: 10,
                                                    )
                                                  : CircleAvatar(
                                                      radius: 10,
                                                      child: Text(
                                                        name[0],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: AppDimens
                                                                    .nameFontSize),
                                                      ),
                                                    )
                                              : const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      secondaryColor,
                                                ),
                                          Text(
                                            dateTime,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: disabledColor,
                                                    fontSize: AppDimens
                                                        .subsubFontSize,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
