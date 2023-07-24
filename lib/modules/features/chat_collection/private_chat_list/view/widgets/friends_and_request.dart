import 'package:flutter/material.dart';
import 'package:moury/modules/features/auth/register/view/widgets/onbarding_register_view.dart';
import 'package:moury/modules/features/chat_collection/private_chat_list/view/widgets/user_received_request_view.dart';
import 'package:moury/modules/features/chat_collection/private_chat_list/view/widgets/user_send_request_view.dart';
import 'package:moury/modules/features/chat_collection/private_chat_list/view/widgets/my_friend_list_view.dart';
import 'package:moury/theme/app_theme.dart';

class FriendsAndRequests extends StatelessWidget {
  const FriendsAndRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Friends & Request'),
                floating: true,
                backgroundColor: secondaryColor,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child: Text(
                      'My friends',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                    Tab(
                        child: Text(
                      'New Request',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                    Tab(
                      child: Text(
                        'Sent',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              MyFriendListView(),
              UserReceivedRequestview(),
              UserSendRequestView(),
            ],
          ),
        )),
      ),
    );
  }
}
