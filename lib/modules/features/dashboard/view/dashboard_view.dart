import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/modules/features/buzz/buzz_feed/view/buzz_feed_view.dart';
import 'package:moury/modules/features/chat_collection/private_chat_list/view/private_chat_list_view.dart';
import 'package:moury/modules/features/dashboard/view_models/dashbaord_view_models.dart';
import 'package:moury/modules/features/explore/view/explore_view.dart';
import 'package:moury/modules/features/profile/user_profile/view/user_profile_view.dart';
import 'package:moury/theme/app_theme.dart';
import '../../community_collection/my_community/view/my_community_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    PrivateChatListView(),
    MyCommunityView(),
    BuzzFeedView(),
    ExploreView(),
    UserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    double navIconSize = 25.0;
    final changeIndex = Get.put(DashboardViewModel());
    return Scaffold(
      backgroundColor: secondaryColor,
      body: PageView(
        controller: changeIndex.pageController,
        children: _widgetOptions,
        onPageChanged: (index) => changeIndex.selectedIndex.value = index,
      ),
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            canvasColor: secondaryColor,
          ),
          child: BottomNavigationBar(
            backgroundColor: secondaryColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.chat_bubble_text,
                  size: navIconSize,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_2,
                  size: navIconSize,
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.flash_on,
                  size: navIconSize,
                ),
                label: 'Buzz(s)',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  size: navIconSize,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: navIconSize,
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: changeIndex.selectedIndex.value,
            selectedFontSize: AppDimens.nameFontSize,
            selectedLabelStyle: const TextStyle(
                color: primaryColor, fontSize: AppDimens.subFontSize),
            selectedIconTheme: const IconThemeData(color: primaryColor),
            unselectedItemColor: disabledColor,
            unselectedLabelStyle: const TextStyle(color: disabledColor),
            selectedItemColor: primaryColor,
            iconSize: 25,
            onTap: changeIndex.changeSelectedIndex,
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
