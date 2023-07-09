import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/color_conversion.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/modules/features/single_community/view_model/single_community_view_model.dart';
import '../../../../theme/app_theme.dart';

class SingleCommunityView extends StatefulWidget {
  const SingleCommunityView({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCommunityView> createState() => _SingleChatViewState();
}

class _SingleChatViewState extends State<SingleCommunityView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Get.put(SingleCommunityViewModel());
    TextEditingController sendTextEditingController = TextEditingController();
    final Map<String, dynamic> args = Get.arguments;
    final String communityId = args['communityId'];
    final String name = args['username'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 1,
            backgroundColor: const Color(0xFFF6F6F6),
            title: ListTile(
              title: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: secondaryColor, fontSize: 17),
              ),
              subtitle: Text(
                "online",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: disabledColor,
                    ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            )),
      ),
      body: GetBuilder<SingleCommunityViewModel>(
        initState: (state) {
          chatViewModel.clearChatList();
          chatViewModel.getSingleCommunityChats(communityId);
          print(chatViewModel.chatList);
          print("boo");
        },
        builder: (controller) {
          return Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: controller.chatList.length,
                    itemBuilder: (context, index) {
                      final chatItem = chatViewModel.chatList[index];

                      return Padding(
                        padding: AppDimens.mainPagePadding,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: avatarBackgroundColor,
                              radius: 20,
                              child: Text(
                                chatItem.senderDetails?.senderUsername?[0] ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            ),
                            title: Text(
                              chatItem.senderDetails?.senderUsername ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorConversion().colorFromHex(
                                        chatItem.senderDetails?.senderColor ??
                                            ''),
                                    fontSize: 17,
                                  ),
                            ),
                            subtitle: Text(
                              chatItem.message ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        const Color.fromARGB(255, 54, 53, 49),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                height: 100,
                padding: AppDimens.typeMessageContainerPadding,
                child: KTextFormField(
                    controller: sendTextEditingController,
                    hint: "send message",
                    suffixIcon: InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        if (sendTextEditingController.text.isNotEmpty) {
                          controller.sendMessage(
                              id: communityId,
                              message: sendTextEditingController.text);
                          sendTextEditingController.clear();
                        }
                      },
                      child: const Icon(
                        Icons.send,
                      ),
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
