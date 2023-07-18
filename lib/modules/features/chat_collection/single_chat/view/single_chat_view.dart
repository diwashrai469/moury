import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/date_time.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/modules/features/chat_collection/single_chat/view_model/single_chat_view_model.dart';
import '../../../../../common/widgets/k_container_for_bottom_sheet.dart';
import '../../../../../common/widgets/k_listile.dart';
import '../../../../../theme/app_theme.dart';

class SingleChatView extends StatelessWidget {
  const SingleChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Get.put(SingleChatViewModel());
    TextEditingController sendTextEditingController = TextEditingController();
    final Map<String, dynamic> args = Get.arguments;
    final String userId = args['userId'];
    final String name = args['username'];
    final String userImage = args['userImage'];
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

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: ListTile(
            horizontalTitleGap: -3,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            leading: userImage.isEmpty
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
                    radius: AppDimens.sssCircleAvatarRadius,
                    backgroundImage: NetworkImage(userImage)),
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
        initState: (state) {
          chatViewModel.clearChatList();
          chatViewModel.getPrivateChats(userId);
        },
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
                        var dateTime = ShowDateAndTimeInAgo()
                            .convertToTimeAgo(chatItem.time!.toInt());

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
                                                  radius: AppDimens
                                                      .ssCircleAvatarRadius,
                                                  backgroundImage:
                                                      NetworkImage(userImage),
                                                ),
                                        )
                                      : null)
                              : null,
                          // title: chatItem.senderId !=
                          //         (index + 1 < controller.chatList.length
                          //             ? controller.chatList[index + 1].senderId
                          //             : 0)
                          //     ? Align(
                          //         alignment:
                          //             chatItem.senderId == chatViewModel.userId
                          //                 ? Alignment.topRight
                          //                 : Alignment.topLeft,
                          //         child: chatItem.senderId !=
                          //                 chatViewModel.userId
                          //             ? Text(
                          //                 dateTime,
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyMedium
                          //                     ?.copyWith(
                          //                         fontWeight: FontWeight.normal,
                          //                         fontSize:
                          //                             AppDimens.subsubFontSize,
                          //                         color: disabledColor),
                          //               )
                          //             :

                          //             //  RichText(
                          //             //     text: TextSpan(
                          //             //       text: name,
                          //             //       style: Theme.of(context)
                          //             //           .textTheme
                          //             //           .bodyMedium
                          //             //           ?.copyWith(
                          //             //             fontWeight: FontWeight.w600,
                          //             //             fontSize:
                          //             //                 AppDimens.subsubFontSize,
                          //             //             color: disabledColor,
                          //             //           ),
                          //             //       children: [
                          //             //         TextSpan(
                          //             //           text: "  $dateTime",
                          //             //           style: Theme.of(context)
                          //             //               .textTheme
                          //             //               .bodyMedium
                          //             //               ?.copyWith(
                          //             //                   fontWeight:
                          //             //                       FontWeight.w600,
                          //             //                   fontSize: AppDimens
                          //             //                       .subsubFontSize,
                          //             //                   color: disabledColor),
                          //             //         ),
                          //             //       ],
                          //             //     ),
                          //             //   )
                          //             null,
                          //       )
                          //     : null,
                          subtitle: Align(
                            alignment: chatItem.senderId == chatViewModel.userId
                                ? Alignment.topRight
                                : Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: chatItem.senderId ==
                                        chatViewModel.userId
                                    ? BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: const Radius.circular(10),
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
                                        bottomLeft: const Radius.circular(10),
                                        bottomRight: const Radius.circular(10)),
                                color: chatItem.senderId == chatViewModel.userId
                                    ? const Color.fromARGB(255, 8, 111, 158)
                                    : const Color(0xFF474747),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w100,
                                              color: chatItem.senderId ==
                                                      chatViewModel.userId
                                                  ? Colors.white
                                                  : Colors.white),
                                    ),
                                    Text(
                                      textAlign: TextAlign.right,
                                      dateTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  AppDimens.subsubsubFontSize,
                                              color: disabledColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                sHeightSpan,
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 3, top: 3, right: 10),
                      width: double.infinity,
                      color: secondaryColor,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                          ),
                          mWidthSpan,
                          Expanded(
                            child: TextField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.normal),
                              minLines: 1,
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                              controller: sendTextEditingController,
                              decoration: const InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(
                                      color: disabledColor,
                                      fontSize: AppDimens.nameFontSize,
                                      fontWeight: FontWeight.normal),
                                  border: InputBorder.none),
                            ),
                          ),
                          mWidthSpan,
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: FloatingActionButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (sendTextEditingController.text.isNotEmpty) {
                                  controller.sendMessage(
                                      id: userId,
                                      message: sendTextEditingController.text);
                                  sendTextEditingController.clear();
                                }
                              },
                              backgroundColor: Colors.grey.shade200,
                              elevation: 0,
                              child: const Icon(
                                Icons.send,
                                color: Colors.black87,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
