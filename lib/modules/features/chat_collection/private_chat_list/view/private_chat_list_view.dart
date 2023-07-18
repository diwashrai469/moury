import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/date_time.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_chat_simmer_effect.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/theme/app_theme.dart';
import '../view_model/private_chat_view_model.dart';

class PrivateChatListView extends StatelessWidget {
  const PrivateChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: GetBuilder<PrivateChatViewModel>(
          init: PrivateChatViewModel(),
          builder: (controller) {
            return Padding(
              padding: AppDimens.mainPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mHeightSpan,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Personal Chat",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: AppDimens.headlineFontSizeOther),
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
                                padding: const EdgeInsets.only(top:20.0),
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

                                  if (chatItem.senderId == controller.userId) {
                                    name = chatItem.receiverDetails
                                            ?.receiverUsername ??
                                        '';
                                    message = "You: ${chatItem.message ?? ''}";
                                    nextPartyId = chatItem.receiverId ?? '';
                                    userImage = chatItem.receiverDetails
                                            ?.receiverProfilePicture ??
                                        '';
                                  } else {
                                    name = chatItem
                                            .senderDetails?.senderUsername ??
                                        '';
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
                                                color: disabledColor,
                                                fontSize: AppDimens.subFontSize,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      title: Text(
                                        name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize:
                                                    AppDimens.nameFontSize),
                                      ),
                                      trailing: Text(
                                        dateTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: disabledColor,
                                                fontSize:
                                                    AppDimens.subsubFontSize,
                                                fontWeight: FontWeight.normal),
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
