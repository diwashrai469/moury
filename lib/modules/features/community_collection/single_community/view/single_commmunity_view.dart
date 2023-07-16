import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/theme/app_theme.dart';

import '../../../../../common/widgets/k_dialog.dart';
import '../../all_community/model_view/all_community_view.model.dart';

class SingleCommunityView extends StatelessWidget {
  const SingleCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final community = Get.put(AllCommunityViewModel());
    final Map<String, dynamic> args = Get.arguments;
    final String communityid = args['communityid'];
    final String communityTitle = args['communityTitle'];
    final Color communityColor = args['communityColor'];
    final String communityDescription = args['communityDescription'];
    final int communityMembers = args['communityMembers'];
    // final String communityImage = args['communityImage'];
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: secondaryColor,
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
                            onKeyPressed: () {
                              AllCommunityViewModel()
                                  .leaveCommunity(id: communityid);
                              Get.back();
                            },
                            doubleHeight: 10,
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
                                  'Leave;',
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
            body: Padding(
              padding: AppDimens.mainPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  elHeightSpan,
                  lHeightSpan,
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: disabledColor,
                        fontSize: AppDimens.titleFontSize),
                  ),
                  mHeightSpan,
                  Text(
                    communityDescription.isEmpty
                        ? "No description"
                        : communityDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade300),
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
                        "${communityMembers.toString()} members",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                  mHeightSpan,
                  sHeightSpan,
                  sHeightSpan,
                  KButton(
                      child: const Text("Join"),
                      onPressed: () {
                        community.joinCommunity(communityid, communityTitle);
                      })
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppDimens.headlineFontSizeMedium),
                      ),
                    ),
                  ),
                ),
                mWidthSpan,
                Text(
                  communityTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: AppDimens.buttonFontSizeMedium),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
