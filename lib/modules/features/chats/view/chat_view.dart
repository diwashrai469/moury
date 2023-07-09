import 'package:flutter/material.dart';
import 'package:moury/modules/features/alluser/view/all_user_view.dart';
import 'package:moury/modules/features/privatechatlist/view/private_chat_list_view.dart';
import 'package:moury/theme/app_theme.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

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
              Tab(text: "Private Chats"),
              Tab(text: "Find friends"),
            ],
          ),
          title: const Text('Chats'),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [PrivateChatListView(), AllUserView()],
        ),
      ),
    ));
  }
}
