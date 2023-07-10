import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/profile/all_user/view/all_user_view.dart';
import 'package:moury/modules/features/buzzfeed/view/buzz_feed_view.dart';
import 'package:moury/modules/features/chat_collection/chats/view/chat_view.dart';
import 'package:moury/modules/features/community_collection/community/view/commuity_view.dart';
import 'package:moury/modules/features/dashboard/view_models/dashbaord_view_models.dart';
import 'package:moury/modules/features/profile/user_profile/view/user_profile_view.dart';
import 'package:moury/theme/app_theme.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    ChatView(),
    CommunityView(),

    BuzzFeedView(),
    AllUserView(),
    // ExploreView(),
    UserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final changeIndex = Get.put(DashboardViewModel());
    return Scaffold(
      body:  PageView(
            controller: changeIndex.pageController,
            children: _widgetOptions,
            onPageChanged: (index) => changeIndex.selectedIndex.value = index,
          ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.chat_bubble_text,
                  size: 30,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_2,
                  size: 30,
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.flash_on,
                  size: 30,
                ),
                label: 'Buzz(s)',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: 30,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: changeIndex.selectedIndex.value,
            selectedIconTheme: const IconThemeData(color: primaryColor),
            unselectedItemColor: disabledColor,
            unselectedLabelStyle: const TextStyle(color: disabledColor),
            selectedItemColor: primaryColor,
            iconSize: 40,
            onTap: changeIndex.changeSelectedIndex,
            elevation: 5,
          )),
    );
  }
}
