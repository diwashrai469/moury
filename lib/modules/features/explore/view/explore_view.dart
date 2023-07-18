import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/theme/app_theme.dart';
import '../../../../common/constant/app_dimens.dart';
import '../../../../common/constant/ui_helpers.dart';
import '../view_model/explore_view_models.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      const Color(0xFF6A8D92), // Dusty Blue
      const Color(0xFF556B2F), // Dark Olive Green
      const Color(0xFF003153), // Prussian Blue
      const Color(0xFFCD5C5C),
      const Color(0xFF191970), // Indian Red
      const Color(0xFF4682B4), // Steel Blue
      const Color(0xFF483D8B), // Dark Slate Blue
      const Color(0xFF191970), // Midnight Blue
    ];

    final exploreData = Get.put(ExploreViewModel());

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: GetBuilder<ExploreViewModel>(
          initState: (state) {
            exploreData.getExplore();
            exploreData.getAllCommunity();
          },
          builder: (controler) {
            return controler.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: AppDimens.mainPagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mHeightSpan,
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Text(
                            "Explore",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontSize: AppDimens.headlineFontSizeOther),
                          ),
                        ),
                        elHeightSpan,
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Suggested community",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: disabledColor,
                                        fontSize:
                                            AppDimens.headlineFontSizeXSmall,
                                        fontWeight: FontWeight.normal),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed("/all-community");
                                },
                                child: Text(
                                  "See more",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: primaryColor,
                                          fontSize: AppDimens.subsubFontSize,
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        sHeightSpan,
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4.5,
                          child: exploreData
                                      .getAllCommunityData?.data?.isEmpty ==
                                  true
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimens.sboarderRadisCircular),
                                  ),
                                  child: const Text("No any community"),
                                )
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controler.counts(exploreData
                                          .getAllCommunityData?.data?.length ??
                                      0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final communityList = exploreData
                                        .getAllCommunityData?.data?[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          "/single-community",
                                          arguments: {
                                            "communityid":
                                                communityList?.sId ?? '',
                                            "communityTitle":
                                                communityList?.name ?? '',
                                            "communityColor": colorList[index],
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: colorList[index],
                                            borderRadius: BorderRadius.circular(
                                                AppDimens
                                                    .sboarderRadisCircular)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        margin: const EdgeInsets.all(4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            sHeightSpan,
                                            ListTile(
                                              visualDensity:
                                                  const VisualDensity(
                                                vertical: 1.5,
                                              ),
                                              leading: Hero(
                                                tag: communityList?.name ?? '',
                                                child: CircleAvatar(
                                                  radius: AppDimens
                                                      .boarderAvatarCircleRaduis,
                                                  backgroundColor:
                                                      boarderAvatarBackgroundColor,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        avatarBackgroundColor,
                                                    radius: AppDimens
                                                        .lCircleAvatarRadius,
                                                    child: Text(
                                                      communityList?.name?[0] ??
                                                          'N/a',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                overflow: TextOverflow.ellipsis,
                                                communityList?.name ?? 'N/a',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: AppDimens
                                                            .buttonFontSizeMedium),
                                              ),
                                            ),
                                            sHeightSpan,
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0, right: 12),
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  communityList?.description ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: disabledColor,
                                                          fontSize: AppDimens
                                                              .subFontSize),
                                                ),
                                              ),
                                            ),
                                            sHeightSpan,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                              ),
                                              child: Text(
                                                  "${communityList?.members} members",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: disabledColor,
                                                          fontSize: AppDimens
                                                              .subFontSize)),
                                            ),
                                            sHeightSpan,
                                            xxsHeightSpan,
                                            xxsHeightSpan
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        lHeightSpan,
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Suggested Users",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: disabledColor,
                                        fontSize:
                                            AppDimens.headlineFontSizeXSmall,
                                        fontWeight: FontWeight.normal),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed("/all-user");
                                },
                                child: Text(
                                  "See more",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: primaryColor,
                                          fontSize: AppDimens.subsubFontSize,
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        sHeightSpan,
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                exploreData.exploreResponseData?.data?.length,
                            itemBuilder: (context, index) {
                              final suggestFriend =
                                  exploreData.exploreResponseData?.data?[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    "/single-user-profile",
                                    arguments: {
                                      "userId": suggestFriend?.sId ?? ''
                                    },
                                  );
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(3),
                                  leading: Hero(
                                    tag: suggestFriend?.sId ?? '',
                                    child: suggestFriend?.profilePicture == null
                                        ? CircleAvatar(
                                            backgroundColor:
                                                avatarBackgroundColor,
                                            radius:
                                                AppDimens.lCircleAvatarRadius,
                                            child: Text(
                                              suggestFriend?.name?[0] ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius:
                                                AppDimens.lCircleAvatarRadius,
                                            backgroundImage: NetworkImage(
                                                suggestFriend?.profilePicture ??
                                                    ''),
                                          ),
                                  ),
                                  title: Text(
                                    suggestFriend?.name ?? 'N/a',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize:
                                                AppDimens.globaleFontSize),
                                  ),
                                  subtitle: Text(
                                    "${suggestFriend?.followers.toString()} followers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: disabledColor,
                                            fontSize: AppDimens.subFontSize,
                                            fontWeight: FontWeight.normal),
                                  ),
                                  trailing: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      CupertinoIcons.person_alt_circle_fill,
                                      color: Colors.white,
                                    ),
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
      ),
    );
  }
}
