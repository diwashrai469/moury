import 'package:get/get.dart';
import 'package:moury/modules/features/chat_collection/chats/view/chat_view.dart';
import 'package:moury/modules/features/community_collection/my_community/view/my_community_view.dart';
import 'package:moury/modules/features/community_collection/single_community/view/single_community_view.dart';
import 'package:moury/modules/features/profile/single_user_profile/view/single_user_profile_view.dart';
import 'package:moury/modules/features/chat_collection/single_chat/view/single_chat_view.dart';
import 'package:moury/modules/features/splash/view/splash_view.dart';
import 'package:moury/modules/features/profile/user_profile/view/widgets/edit_user_profile.dart';

import '../../modules/features/community_collection/all_community/view/all_community_view.dart';
import '../../modules/features/chat_collection/private_chat_list/view/private_chat_list_view.dart';
import '../../modules/features/dashboard/view/dashboard_view.dart';
import '../../modules/features/explore/view/explore_view.dart';
import '../../modules/features/auth/login/view/login_view.dart';
import '../../modules/features/auth/register/view/register_view.dart';
import '../../modules/features/profile/user_profile/view/user_profile_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => const LoginView()),
    GetPage(name: '/register', page: () => const RegisterView()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(
        name: '/private-chat-list', page: () => const PrivateChatListView()),
    GetPage(name: '/explore', page: () => const ExploreView()),
    GetPage(name: '/user-profile', page: () => const UserProfileView()),
    GetPage(
        name: '/edit-user-profile', page: () => const EditUserProfileView()),
    GetPage(name: '/single-chat', page: () => const SingleChatView()),
    GetPage(name: '/splash', page: () => const SplashView()),
    GetPage(name: '/my-community', page: () => const MyCommunityView()),
    GetPage(name: '/single-community', page: () => const SingleCommunityView()),
    GetPage(name: '/all-community', page: () =>const AllCommunityView()),
        GetPage(name: '/chat', page: () => const ChatView()),
          GetPage(name: '/single-user-profile', page: () => const SingleUserProfileView()),

  ];
}
