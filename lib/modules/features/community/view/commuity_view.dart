import 'package:flutter/material.dart';
import 'package:moury/modules/features/allcommunity/view/all_community_view.dart';
import 'package:moury/modules/features/mycommunity/view/my_community_view.dart';
import 'package:moury/theme/app_theme.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicatorColor: primaryColor,
            tabs: [
              Tab(text: "My community"),
              Tab(text: "Find community"),
            ],
          ),
          title: const Text('Community'),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [MyCommunityView(), AllCommunityView()],
        ),
      ),
    ));
  }
}
