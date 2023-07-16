import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moury/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class KBuzzSimmerEffect extends StatelessWidget {
  const KBuzzSimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 18,
                              color: avatarBackgroundColor,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 80,
                              height: 12,
                              color: avatarBackgroundColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: avatarBackgroundColor,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: avatarBackgroundColor,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 30,
                            height: 12,
                            color: avatarBackgroundColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.chat_bubble,
                            color: avatarBackgroundColor,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 30,
                            height: 12,
                            color: avatarBackgroundColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.share,
                            color: avatarBackgroundColor,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 40,
                            height: 12,
                            color: avatarBackgroundColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(
                    color: disabledColor,
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
