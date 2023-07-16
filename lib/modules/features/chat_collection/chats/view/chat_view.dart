// import 'package:flutter/material.dart';
// import 'package:moury/common/constant/app_dimens.dart';
// import 'package:moury/modules/features/profile/all_user/view/all_user_view.dart';
// import 'package:moury/modules/features/chat_collection/private_chat_list/view/private_chat_list_view.dart';
// import 'package:moury/theme/app_theme.dart';

// class ChatView extends StatelessWidget {
//   const ChatView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           bottom: const TabBar(
//             indicatorColor: primaryColor,
//             tabs: [
//               Tab(text: "Private Chats"),
//               Tab(text: "Find friends"),
//             ],
//           ),
//           title: Text(
//             'Chats',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.white, fontSize: AppDimens.titleFontSize),
//           ),
//         ),
//         body: const TabBarView(
//           physics: NeverScrollableScrollPhysics(),
//           children: [PrivateChatListView(), AllUserView()],
//         ),
//       ),
//     ));
//   }
// }
