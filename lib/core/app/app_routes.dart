import 'package:get/get.dart';
import 'package:moury/modules/features/auth/signup/view/signup_view.dart';
import 'package:moury/modules/features/auth/signup/view/widgets/onbarding_signup_view.dart';
import 'package:moury/modules/features/buzz/buzz_feed/view/widgets/add_buzz_feed_view.dart';
import 'package:moury/modules/features/community_collection/my_community/view/my_community_view.dart';
import 'package:moury/modules/features/community_collection/single_community_chat/view/single_community_chat_view.dart';
import 'package:moury/modules/features/profile/all_user/view/all_user_view.dart';
import 'package:moury/modules/features/profile/single_user_profile/view/single_user_profile_view.dart';
import 'package:moury/modules/features/chat_collection/single_chat/view/single_chat_view.dart';
import 'package:moury/modules/features/splash/view/splash_view.dart';
import 'package:moury/modules/features/profile/user_profile/view/widgets/edit_user_profile.dart';
import '../../modules/features/community_collection/all_community/view/all_community_view.dart';
import '../../modules/features/chat_collection/private_chat_list/view/private_chat_list_view.dart';
import '../../modules/features/community_collection/single_community/view/single_commmunity_view.dart';
import '../../modules/features/dashboard/view/dashboard_view.dart';
import '../../modules/features/explore/view/explore_view.dart';
import '../../modules/features/auth/login/view/login_view.dart';
import '../../modules/features/auth/register/view/register_view.dart';
import '../../modules/features/profile/user_profile/view/user_profile_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => const LoginView()),
    GetPage(name: '/register', page: () => const RegisterView()),
    GetPage(name: '/dashboard', page: () => const DashboardView()),
    GetPage(
        name: '/private-chat-list', page: () => const PrivateChatListView()),
    GetPage(name: '/explore', page: () => const ExploreView()),
    GetPage(name: '/user-profile', page: () => const UserProfileView()),
    GetPage(
        name: '/edit-user-profile', page: () => const EditUserProfileView()),
    GetPage(name: '/single-chat', page: () => const SingleChatView()),
    GetPage(name: '/splash', page: () => const SplashView()),
    GetPage(name: '/my-community', page: () => const MyCommunityView()),
    GetPage(
        name: '/single-community-chat', page: () => const SingleCommunityChatView()),
    GetPage(name: '/all-community', page: () => const AllCommunityView()),
    // GetPage(name: '/chat', page: () => const ChatView()),
    GetPage(
        name: '/single-user-profile',
        page: () => const SingleUserProfileView()),
    GetPage(name: '/add-buzz-feed', page: () => const AddBuzzFeedView()),
    GetPage(name: '/signup', page: () => const SignupView()),
    GetPage(name: '/ask-user-fullname', page: () => const AskUserFullName()),
    GetPage(name: '/ask-user-name', page: () => const AskUserName()),
    GetPage(name: '/ask-user-password', page: () => const AskUserPassword()),
     GetPage(name: '/ask-user-email', page: () => const AskUserEmail()),
      GetPage(name: '/single-community', page: () => const SingleCommunityView()),
         GetPage(name: '/all-user', page: () => const AllUserView()),
  ];
}
