import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/community_collection/all_community/model_view/all_community_view.model.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../../../../../common/constant/ui_helpers.dart';
import '../../../../../theme/app_theme.dart';

class AllCommunityView extends StatelessWidget {
  const AllCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final communityModel = Get.put(AllCommunityViewModel());
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<AllCommunityViewModel>(
        initState: (state) {
          communityModel.getAllCommunity();
        },
        builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: AppDimens.mainPagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "Community",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: AppDimens.headlineFontSizeOther),
                        ),
                      ),
                      mHeightSpan,
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              controller.getAllCommunityData?.data?.length,
                          itemBuilder: (context, index) {
                            final getCommunityList =
                                controller.getAllCommunityData?.data?[index];

                            return InkWell(
                              onTap: () {
                                print(
                                    "from allcommunity ${getCommunityList?.sId ?? ''}");
                                Get.toNamed(
                                  "/single-community",
                                  arguments: {
                                    "communityid": getCommunityList?.sId ?? '',
                                    "communityTitle":
                                        getCommunityList?.name ?? '',
                                    "communityColor":
                                        const Color.fromARGB(255, 85, 110, 122),
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 85, 110, 122),
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.sboarderRadisCircular),
                                ),
                                height: MediaQuery.of(context).size.height / 5,
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: avatarBackgroundColor,
                                        radius: 25,
                                        child: Text(
                                          getCommunityList?.name?[0] ?? '',
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
                                        getCommunityList?.name ?? 'N/a',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize:
                                                    AppDimens.nameFontSize,
                                                color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "${getCommunityList?.members?.toString()} members",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        getCommunityList?.description ??
                                            "No description",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey.shade300),
                                      ),
                                    )
                                  ],
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
