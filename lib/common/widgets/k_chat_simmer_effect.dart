import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_theme.dart';
import '../constant/app_dimens.dart';

class KChatSimmerEffect extends StatelessWidget {
  const KChatSimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4, // Placeholder count
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(5),
            leading: const CircleAvatar(
              backgroundColor: avatarBackgroundColor,
              radius: AppDimens.elCircleAvatarRadius,
            ),
            title: Container(
              width: double.infinity,
              height: 18,
              color: avatarBackgroundColor,
            ),
            subtitle: Container(
              width: 80,
              height: 12,
              color: avatarBackgroundColor,
            ),
          );
        },
      ),
    );
  }
}
