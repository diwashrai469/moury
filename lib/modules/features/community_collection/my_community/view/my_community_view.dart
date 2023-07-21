import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/widgets/k_chat_simmer_effect.dart';
import 'package:moury/modules/features/community_collection/my_community/model_view/my_community_view.model.dart';
import 'package:moury/modules/features/community_collection/my_community/view/widgets/create_community.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../common/widgets/k_textformfield.dart';
import '../../../../../theme/app_theme.dart';

class MyCommunityView extends StatelessWidget {
  const MyCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MyCommunityViewModel>(
          init: MyCommunityViewModel(),
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
                  controller.isLoading
                      ? const Expanded(child: KChatSimmerEffect())
                      : controller.communityData.isEmpty == true
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "No any community found!.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: disabledColor,
                                        fontSize: AppDimens.subFontSize,
                                      ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.communityData.length,
                                itemBuilder: (context, index) {
                                  final chatItem =
                                      controller.communityData[index];

                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        '/single-community-chat',
                                        arguments: {
                                          'communityId':
                                              chatItem.communityId?.sId,
                                          'username':
                                              chatItem.communityId?.name,
                                          'communityMembers':
                                              chatItem.communityId?.members,
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
                                          chatItem.communityId?.name?[0] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize:
                                                      AppDimens.nameFontSize,
                                                  color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        chatItem.communityId?.name ?? 'N/a',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize:
                                                    AppDimens.nameFontSize),
                                      ),
                                      subtitle: Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${chatItem.communityId?.members.toString()} members",
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
                            )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
