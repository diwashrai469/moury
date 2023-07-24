import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/community_collection/my_community/model_view/my_community_view.model.dart';
import 'package:moury/modules/features/community_collection/my_community/view/widgets/create_community.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../common/widgets/k_textformfield.dart';
import '../../../../../theme/app_theme.dart';

class MyCommunityView extends StatefulWidget {
  const MyCommunityView({super.key});

  @override
  State<MyCommunityView> createState() => _MyCommunityViewState();
}

class _MyCommunityViewState extends State<MyCommunityView> {
  final controller = Get.put(MyCommunityViewModel());
  @override
  void initState() {
    controller.getAllCommunityChatListFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MyCommunityViewModel>(
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
                          "Community Chat",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: AppDimens.headlineFontSizeOther),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(const CreateCommunityView());
                            },
                            child: const Icon(
                              Icons.people_alt_outlined,
                              color: Colors.white,
                            ),
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
                      hint: "   Search community",
                      suffixIcon: const Icon(
                        CupertinoIcons.search,
                        color: disabledColor,
                      ),
                    ),
                  ),
                  sHeightSpan,
                  Obx(() => Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller
                              .allCommunityChatListFromFirebaseModel.length,
                          itemBuilder: (context, index) {
                            final chatItem = controller
                                .allCommunityChatListFromFirebaseModel[index];
                            print("datasdfasdf${chatItem.senderMessage}");

                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  '/single-community-chat',
                                  arguments: {
                                    'communityId': chatItem.communityId,
                                    'username': chatItem.communityName,
                                    "refreshMyCommunity":
                                        controller.getMyCommunity,
                                    "isFromCommunityView": true
                                  },
                                );
                              },
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(5),
                                leading: CircleAvatar(
                                  backgroundColor: avatarBackgroundColor,
                                  radius: AppDimens.elCircleAvatarRadius,
                                  child: Text(
                                    chatItem.communityName?[0] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: AppDimens.nameFontSize,
                                            color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  chatItem.communityName ?? 'N/a',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontSize: AppDimens.nameFontSize),
                                ),
                                subtitle: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "@${chatItem.senderUsername}: ${chatItem.senderMessage.toString()} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: disabledColor,
                                          fontSize: AppDimens.subFontSize,
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
