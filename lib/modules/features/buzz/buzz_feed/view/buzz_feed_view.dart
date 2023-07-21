import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/modules/features/buzz/buzz_feed/view_models/buzz_feed_view_models.dart';
import 'package:moury/theme/app_theme.dart';
import '../../../../../common/widgets/k_buzz_simmer_effect.dart';

class BuzzFeedView extends StatelessWidget {
  const BuzzFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final buzzFeedModel = Get.put(BuzzFeedViewModels());
    return GetBuilder<BuzzFeedViewModels>(
      initState: (state) {
        buzzFeedModel.getBuzzFeed();
      },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: AppDimens.mainPagePadding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              mHeightSpan,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Text(
                      "Buzz",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: AppDimens.headlineFontSizeOther),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/add-buzz-feed',
                        );
                      },
                      child: const Text("+ Buzz"),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(
                  "Buzz for more connections!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: disabledColor),
                ),
              ),
              mHeightSpan,
              const Divider(
                color: disabledColor,
              ),
              mHeightSpan,
              controller.isLoading
                  ? const Expanded(child: KBuzzSimmerEffect())
                  : Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.buzzFeedData?.data?.length,
                        itemBuilder: (context, index) {
                          final buzzIndex =
                              controller.buzzFeedData?.data?[index];

                          return Container(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10, bottom: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    buzzIndex?.userId?.profilePicture
                                                    ?.isEmpty ==
                                                true ||
                                            buzzIndex?.userId?.profilePicture ==
                                                null
                                        ? CircleAvatar(
                                            radius: 20,
                                            child: Text(
                                                buzzIndex?.userId?.name?[0] ??
                                                    'N/a'),
                                          )
                                        : CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                buzzIndex?.userId
                                                        ?.profilePicture ??
                                                    ''),
                                          ),
                                    sWidthSpan,
                                    sWidthSpan,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          buzzIndex?.userId?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      AppDimens.nameFontSize),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.calculateTimeAgo(
                                                  buzzIndex?.createdAt ?? ''),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontSize: AppDimens
                                                          .subsubFontSize,
                                                      color: disabledColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                mHeightSpan,
                                Text(
                                  buzzIndex?.caption ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: AppDimens.subFontSize,
                                          fontWeight: FontWeight.normal),
                                ),
                                mHeightSpan,
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                        mWidthSpan,
                                        Text(
                                            buzzIndex?.likes.toString() ?? "0"),
                                      ],
                                    ),
                                    mWidthSpan,
                                    Row(
                                      children: [
                                        const Icon(
                                            color: Colors.white,
                                            CupertinoIcons.chat_bubble),
                                        mWidthSpan,
                                        Text(buzzIndex?.comments.toString() ??
                                            ''),
                                      ],
                                    ),
                                    mWidthSpan,
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.bar_chart,
                                          color: disabledColor,
                                        ),
                                        sWidthSpan,
                                      ],
                                    )
                                  ],
                                ),
                                mHeightSpan,
                                sHeightSpan,
                                const Divider(
                                  color: disabledColor,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
            ]),
          )),
        );
      },
    );
  }
}
