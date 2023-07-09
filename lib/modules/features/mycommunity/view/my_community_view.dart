import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/mycommunity/model_view/my_community_view.model.dart';
import '../../../../common/constant/app_dimens.dart';
import '../../../../theme/app_theme.dart';

class MyCommunityView extends StatelessWidget {
  const MyCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final community = Get.put(MyCommunityViewModel());
    return Scaffold(
      body: GetBuilder<MyCommunityViewModel>(
        initState: (state) {
          community.getCommunity();
        },
        builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: AppDimens.mainPagePadding,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              controller.communityData?.communities?.length,
                          itemBuilder: (context, index) {
                            final chatItem =
                                controller.communityData?.communities?[index];

                            return InkWell(
                              onTap: () {
                                Get.toNamed('/single-community', arguments: {
                                  'communityId': chatItem?.communityId?.sId,
                                  'username': chatItem?.communityId?.name,
                                });
                              },
                              child: Card(
                                elevation: 0.2,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: avatarBackgroundColor,
                                    radius: 25,
                                    child: Text(
                                      chatItem?.communityId?.name?[0] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 18,
                                              color: Colors.white),
                                    ),
                                  ),
                                  title: Text(
                                    chatItem?.communityId?.name ?? 'N/a',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: secondaryColor,
                                            fontSize: 17),
                                  ),
                                  subtitle: Text(
                                      "${chatItem?.communityId?.members.toString()} members"),
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
    );
  }
}
