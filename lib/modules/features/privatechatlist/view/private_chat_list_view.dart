import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/theme/app_theme.dart';

import '../view_model/private_chat_view_model.dart';

class PrivateChatListView extends StatelessWidget {
  const PrivateChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Get.put(PrivateChatViewModel());
    return Scaffold(
      body: GetBuilder<PrivateChatViewModel>(
        initState: (state) {
          chatViewModel.getPrivateChatList();
        },
        builder: (controller) {
          if (controller.chatList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: AppDimens.mainPagePadding,
              child: Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.chatList.length,
                        itemBuilder: (context, index) {
                          final chatItem = controller.chatList[index];
                          var dateTime = chatViewModel
                              .convertToTimeAgo(chatItem.time!.toInt());
                          String name = '';
                          String message = '';
                          String nextPartyId = '';

                          if (chatItem.senderId == chatViewModel.userId) {
                            name = chatItem.receiverDetails?.receiverUsername ??
                                '';
                            message = chatItem.message ?? '';
                            nextPartyId = chatItem.receiverId ?? '';
                          } else {
                            name = chatItem.senderDetails?.senderUsername ?? '';
                            message = chatItem.message ?? '';
                            nextPartyId = chatItem.senderId ?? '';
                          }

                          return InkWell(
                            onTap: () {
                              Get.toNamed('/single-chat', arguments: {
                                'userId': nextPartyId,
                                'username': name,
                              });
                            },
                            child: Card(
                              elevation: 0.4,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: chatItem
                                                .senderDetails
                                                ?.senderProfilePicture
                                                ?.isEmpty ==
                                            true ||
                                        chatItem.senderDetails
                                                ?.senderProfilePicture ==
                                            null
                                    ? CircleAvatar(
                                        backgroundColor: avatarBackgroundColor,
                                        radius: 30,
                                        child: Text(
                                          name[0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                        ),
                                      )
                                    : ClipOval(
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(chatItem
                                                  .senderDetails
                                                  ?.senderProfilePicture ??
                                              ''),
                                        ),
                                      ),
                                subtitle: Text(
                                  message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: disabledColor,
                                      ),
                                ),
                                title: Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: secondaryColor, fontSize: 17),
                                ),
                                trailing: Text(
                                  dateTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: disabledColor),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
