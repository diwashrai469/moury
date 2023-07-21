import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/theme/app_theme.dart';

import '../../../../../common/widgets/k_dialog.dart';
import '../../all_community/model_view/all_community_view.model.dart';

class SingleCommunityView extends StatefulWidget {
  const SingleCommunityView({Key? key}) : super(key: key);

  @override
  State<SingleCommunityView> createState() => _SingleCommunityViewState();
}

class _SingleCommunityViewState extends State<SingleCommunityView> {
  final AllCommunityViewModel controller = Get.put(AllCommunityViewModel());

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> args = Get.arguments;
    final String communityid = args['communityid'];
    controller.getSingleCommunity(communityid);
    fetchCommunityAndCheckMembership(communityid);
  }

  void fetchCommunityAndCheckMembership(String communityid) async {
    await controller.getMyCommunity();
    controller.alreadyJoined(communityid);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final Color communityColor = args['communityColor'];
    final String communityid = args['communityid'];
    final String communityTitle = args['communityTitle'];
    final VoidCallback? refreshMyCommunity = args['refreshMyCommunity'];
    final bool? isFromCommunityView = args['isFromCommunityView'];

    return Material(
      child: GetBuilder<AllCommunityViewModel>(
        init: controller,
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(MediaQuery.of(context).size.height / 7.5),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: communityColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: PopupMenuButton<String>(
                          offset: const Offset(0, 40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          onSelected: (String option) {
                            if (option == 'Leave') {
                              kDialogBox(
                                context,
                                heading: "Confirm!",
                                message:
                                    "Are you sure you want to leave this group?",
                                onKeyPressed: () async {
                                  await controller.leaveCommunity(
                                      id: communityid);
                                  controller.alreadyJoined(communityid);
                                  if (isFromCommunityView == true) {
                                    refreshMyCommunity!();
                                    Get.back();
                                  }
                                  Get.back();

                                  Get.back();
                                },
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                height: 23,
                                value: 'Leave',
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.logout_rounded,
                                      color: primaryColor,
                                    ),
                                    sHeightSpan,
                                    Text(
                                      'Leave',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                          child: const Icon(Icons.more_vert),
                        ),
                      )
                    ],
                  ),
                ),
                body: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: AppDimens.mainPagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            elHeightSpan,
                            lHeightSpan,
                            Text(
                              "Description",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: disabledColor,
                                    fontSize: AppDimens.titleFontSize,
                                  ),
                            ),
                            mHeightSpan,
                            Text(
                              controller.getSingleCommunityData?.data?.first
                                      .description ??
                                  "No description",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade300,
                                  ),
                            ),
                            mHeightSpan,
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: disabledColor,
                                  size: 25,
                                ),
                                sWidthSpan,
                                Text(
                                  "${controller.getSingleCommunityData?.data?.first.members.toString()} members",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                            mHeightSpan,
                            sHeightSpan,
                            sHeightSpan,
                            Obx(
                              () => KButton(
                                isBusy: controller.isLoading,
                                child: Text(controller.communityJoin.value),
                                onPressed: () {
                                  if (controller.communityJoin.value ==
                                      "Join") {
                                    controller.joinCommunity(
                                      communityid,
                                      controller.getAllCommunityData?.data
                                              ?.first.name ??
                                          '',
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Positioned(
                top: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Hero(
                        tag: communityTitle,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          child: Text(
                            communityTitle[0],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: AppDimens.headlineFontSizeMedium,
                                ),
                          ),
                        ),
                      ),
                    ),
                    mWidthSpan,
                    Text(
                      communityTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppDimens.buttonFontSizeMedium,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
