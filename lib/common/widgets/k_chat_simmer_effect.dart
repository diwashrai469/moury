import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_theme.dart';
import '../constant/app_dimens.dart';

class KChatSimmerEffect extends StatelessWidget {
  const KChatSimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF3C3C3C),
      highlightColor: const Color.fromARGB(255, 71, 71, 71).withOpacity(1),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 15, // Placeholder count
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
              decoration: BoxDecoration(
                  color: avatarBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                  color: avatarBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              width: MediaQuery.of(context).size.width / 4,
              height: 12,
            ),
          );
        },
      ),
    );
  }
}
