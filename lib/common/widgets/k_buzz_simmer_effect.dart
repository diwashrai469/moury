import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class KBuzzSimmerEffect extends StatelessWidget {
  const KBuzzSimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF3C3C3C),
      highlightColor: const Color.fromARGB(255, 71, 71, 71).withOpacity(1),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              top: 10,
              bottom: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: avatarBackgroundColor,
                      radius: 20,
                    ),
                    sWidthSpan,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 18,
                            decoration: BoxDecoration(
                                color: avatarBackgroundColor,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          xsHeightSpan,
                          Container(
                            width: 80,
                            height: 12,
                            decoration: BoxDecoration(
                                color: avatarBackgroundColor,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                mHeightSpan,
                Container(
                  width: double.infinity,
                  height: 12,
                  decoration: BoxDecoration(
                      color: avatarBackgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                ),
                mHeightSpan,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: avatarBackgroundColor,
                        ),
                        sHeightSpan,
                        Container(
                          width: MediaQuery.of(context).size.width / 15,
                          height: 12,
                          decoration: BoxDecoration(
                              color: avatarBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.chat_bubble,
                          color: avatarBackgroundColor,
                        ),
                        sHeightSpan,
                        Container(
                          width: MediaQuery.of(context).size.width / 15,
                          height: 12,
                          decoration: BoxDecoration(
                              color: avatarBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.share,
                          color: avatarBackgroundColor,
                        ),
                        sHeightSpan,
                        Container(
                          width: MediaQuery.of(context).size.width / 15,
                          height: 12,
                          decoration: BoxDecoration(
                              color: avatarBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                  ],
                ),
                mHeightSpan,
                const Divider(
                  color: disabledColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
