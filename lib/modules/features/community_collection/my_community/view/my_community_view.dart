import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/widgets/k_chat_simmer_effect.dart';
import 'package:moury/modules/features/community_collection/my_community/model_view/my_community_view.model.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../common/widgets/k_textformfield.dart';
import '../../../../../theme/app_theme.dart';

class MyCommunityView extends StatelessWidget {
  const MyCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final community = Get.put(MyCommunityViewModel());
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: GetBuilder<MyCommunityViewModel>(
          initState: (state) {
            community.getMyCommunity();
          },
          builder: (controller) {
            return controller.communityData?.communities?.isEmpty == true
                ? Center(
                    child: Text(
                      "You haven't joined any community yet.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: disabledColor,
                            fontSize: AppDimens.subFontSize,
                          ),
                    ),
                  )
                : Padding(
                    padding: AppDimens.mainPagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mHeightSpan,
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Community Chat",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontSize: AppDimens.headlineFontSizeOther),
                          ),
                        ),
                        mHeightSpan,
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: KTextFormField(
                            hint: "   Search friends",
                            suffixIcon: Icon(
                              CupertinoIcons.search,
                              color: disabledColor,
                            ),
                          ),
                        ),
                        sHeightSpan,
                        controller.isLoading
                            ? const KChatSimmerEffect()
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: controller
                                      .communityData?.communities?.length,
                                  itemBuilder: (context, index) {
                                    final chatItem = controller
                                        .communityData?.communities?[index];

                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          '/single-community-chat',
                                          arguments: {
                                            'communityId':
                                                chatItem?.communityId?.sId,
                                            'username':
                                                chatItem?.communityId?.name,
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(5),
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              avatarBackgroundColor,
                                          radius:
                                              AppDimens.elCircleAvatarRadius,
                                          child: Text(
                                            chatItem?.communityId?.name?[0] ??
                                                '',
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
                                          chatItem?.communityId?.name ?? 'N/a',
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
                                          "${chatItem?.communityId?.members.toString()} members",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: disabledColor,
                                                  fontSize:
                                                      AppDimens.subFontSize,
                                                  fontWeight:
                                                      FontWeight.normal),
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
