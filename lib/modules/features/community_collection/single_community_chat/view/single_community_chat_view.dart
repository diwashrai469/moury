import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_container_for_bottom_sheet.dart';
import 'package:moury/modules/features/community_collection/single_community_chat/view_model/single_community_chat_view_model.dart';
import '../../../../../common/constant/date_time.dart';
import '../../../../../common/widgets/k_listile.dart';
import '../../../../../theme/app_theme.dart';

class SingleCommunityChatView extends StatefulWidget {
  const SingleCommunityChatView({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCommunityChatView> createState() => _SingleChatViewState();
}

class _SingleChatViewState extends State<SingleCommunityChatView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Get.put(SingleCommunityChatViewModel());
    TextEditingController sendTextEditingController = TextEditingController();
    final Map<String, dynamic> args = Get.arguments;
    final String communityId = args['communityId'];
    final String name = args['username'];
    final int communityMembers = args['communityMembers'];
    final VoidCallback? refreshMyCommunity = args['refreshMyCommunity'];
    final bool? isFromCommunityView = args['isFromCommunityView'];

    void kshowBottomSheet(String senderId) {
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
                        arguments: {'userId': senderId});
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          actions: const [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: PopupMenuButton<String>(
            //     offset: const Offset(0, 40),
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(8.0),
            //       ),
            //     ),
            //     onSelected: (String option) {
            //       if (option == 'Leave') {
            //         kDialogBox(
            //           context,
            //           heading: "Confirm!",
            //           message: "Are you sure you want to leave this group?",
            //           onKeyPressed: () {
            //             chatViewModel.leaveCommunity(id: communityId);
            //             Get.back(result: true);
            //             Get.back(result: true);
            //           },
            //           doubleHeight: 10,
            //         );
            //       }
            //     },
            //     itemBuilder: (BuildContext context) {
            //       return [
            //         PopupMenuItem<String>(
            //           height: 23,
            //           value: 'Leave',
            //           child: Row(
            //             children: [
            //               const Icon(
            //                 Icons.logout_rounded,
            //                 color: primaryColor,
            //               ),
            //               sHeightSpan,
            //               Text(
            //                 'Leave;',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .bodyMedium
            //                     ?.copyWith(
            //                       color: primaryColor,
            //                     ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ];
            //     },
            //     child: const Icon(Icons.more_vert),
            //   ),
            // )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: InkWell(
            onTap: () {
              Get.toNamed(
                "/single-community",
                arguments: {
                  'communityid': communityId,
                  'communityTitle': name,
                  'communityColor': Colors.blueGrey,
                  'refreshMyCommunity': refreshMyCommunity,
                  "isFromCommunityView": isFromCommunityView
                },
              );
            },
            child: ListTile(
              horizontalTitleGap: 4,
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(vertical: -3),
              leading: CircleAvatar(
                backgroundColor: avatarBackgroundColor,
                radius: AppDimens.sCircleAvatarRadius,
                child: Text(
                  name[0],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              title: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: AppDimens.nameFontSize,
                    ),
              ),
              subtitle: Text(
                "$communityMembers Members",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: AppDimens.subsubFontSize,
                      color: disabledColor,
                    ),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          )),
      body: GetBuilder<SingleCommunityChatViewModel>(
        initState: (state) {
          chatViewModel.clearChatList();
          chatViewModel.getSingleCommunityChats(communityId);
        },
        builder: (controller) {
          return Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: controller.chatList.length,
                    itemBuilder: (context, index) {
                      final chatItem = chatViewModel.chatList[index];
                      var dateTime = ShowDateAndTimeInAgo()
                          .convertToTimeAgo(chatItem.time!.toInt());

                      return ListTile(
                        horizontalTitleGap: 2,
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: InkWell(
                            onTap: () {
                              kshowBottomSheet(chatItem.senderId ?? '');
                            },
                            child: chatItem.senderDetails?.senderProfilePicture
                                            ?.isEmpty ==
                                        true ||
                                    chatItem.senderDetails
                                            ?.senderProfilePicture ==
                                        null
                                ? CircleAvatar(
                                    backgroundColor: avatarBackgroundColor,
                                    radius: AppDimens.sCircleAvatarRadius,
                                    child: Text(
                                      chatItem.senderDetails
                                              ?.senderUsername?[0] ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: AppDimens.nameFontSize,
                                              color: Colors.white),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: AppDimens.sCircleAvatarRadius,
                                    backgroundImage: NetworkImage(chatItem
                                            .senderDetails
                                            ?.senderProfilePicture ??
                                        ''),
                                  ),
                          ),
                        ),
                        title: RichText(
                          text: TextSpan(
                            text: chatItem.senderDetails?.senderUsername ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppDimens.subsubFontSize,
                                  color:
                                      const Color.fromARGB(255, 11, 143, 204),
                                ),
                            children: [
                              TextSpan(
                                text: "  $dateTime",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: AppDimens.subsubFontSize,
                                        color: disabledColor),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 90, 88, 88)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                chatItem.message ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
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
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
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
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppDimens.nameFontSize),
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
                                      id: communityId,
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
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
