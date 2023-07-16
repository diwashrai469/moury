// import 'package:flutter/material.dart';
// import 'package:moury/common/constant/app_dimens.dart';
// import 'package:moury/modules/features/community_collection/all_community/view/all_community_view.dart';
// import 'package:moury/modules/features/community_collection/my_community/view/my_community_view.dart';
// import 'package:moury/theme/app_theme.dart';

// class CommunityView extends StatelessWidget {
//   const CommunityView({super.key});

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
//               Tab(text: "My community"),
//               Tab(text: "Find community"),
//             ],
//           ),
//           title: Text(
//             'Community',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.white, fontSize: AppDimens.titleFontSize),
//           ),
//         ),
//         body: const TabBarView(
//           physics: NeverScrollableScrollPhysics(),
//           children: [MyCommunityView(), AllCommunityView()],
//         ),
//       ),
//     ));
//   }
// }
