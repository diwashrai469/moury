import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/community_collection/all_community/model_view/all_community_view.model.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../theme/app_theme.dart';

class AllCommunityView extends StatelessWidget {
  const AllCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final community = Get.put(AllCommunityViewModel());
    return Scaffold(
      body: GetBuilder<AllCommunityViewModel>(
        initState: (state) {
          community.getAllCommunity();
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
                              controller.getAllCommunityData?.data?.length,
                          itemBuilder: (context, index) {
                            final getCommunityList =
                                controller.getAllCommunityData?.data?[index];

                            return Card(
                              elevation: 0.2,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: avatarBackgroundColor,
                                  radius: 25,
                                  child: Text(
                                    getCommunityList?.name?[0] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  getCommunityList?.name ?? 'N/a',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: secondaryColor, fontSize: 17),
                                ),
                                subtitle: Text(
                                    "${getCommunityList?.members?.toString()} members"),
                                trailing: ElevatedButton(
                                    child: const Text("Join"),
                                    onPressed: () {
                                      controller.joinCommunity(
                                          getCommunityList?.sId ?? '',
                                          getCommunityList?.name ?? '');
                                    }),
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
