import 'package:dio/dio.dart';
import 'package:moury/modules/data/all_users/model/all_users_response_model.dart';
import 'package:moury/modules/data/all_users/model/follow_response_model.dart';
import 'package:moury/modules/data/all_users/model/get_received_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/get_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/my_friends_response_model.dart';
import 'package:moury/modules/data/all_users/model/send_friend_request_response_model.dart';
import '../../../../core/services/intercepters.dart';
import '../model/friend_request_response_model.dart';

class GetAllFriendServices {
  Future<AllUsersResponseModel> getAllUsers() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "profile",
    );
    return AllUsersResponseModel.fromJson(response.data);
  }

  Future<MyFriendsResponseModel> myFriends() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "friendship/friends",
    );
    return MyFriendsResponseModel.fromJson(response.data);
  }

  Future<SendFriendResonseModel> sendFriendRequest(
      String friendRequestId) async {
    Dio dio = getDioInstance();

    final response = await dio
        .post("friendship/requests/send", data: {"to": friendRequestId});
    return SendFriendResonseModel.fromJson(response.data);
  }

  Future<AllUsersResponseModel> getSingleUser(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "profile?_id=$userId",
    );
    return AllUsersResponseModel.fromJson(response.data);
  }

  Future<CheckFriendResponseModel> checkIsFriend(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "friendship/with/$userId",
    );
    return CheckFriendResponseModel.fromJson(response.data);
  }

  Future<FriendRequestResponseModel> addUser(String userId) async {
    Dio dio = getDioInstance();

    final response =
        await dio.post("friendship/requests/send", data: {"to": userId});
    return FriendRequestResponseModel.fromJson(response.data);
  }

  Future<FriendRequestResponseModel> acceptUser(String userId) async {
    Dio dio = getDioInstance();

    final response =
        await dio.post("friendship/requests/accept", data: {"from": userId});
    return FriendRequestResponseModel.fromJson(response.data);
  }

  Future<FriendRequestResponseModel> deleteSentRequest(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.delete(
      "friendship/requests/deleteSent/$userId",
    );
    return FriendRequestResponseModel.fromJson(response.data);
  }

  Future<FriendRequestResponseModel> rejectRequest(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.delete(
      "friendship/requests/reject/$userId",
    );
    return FriendRequestResponseModel.fromJson(response.data);
  }

  Future<GetRequestResponseModel> getRequest() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "friendship/requests/sent",
    );
    return GetRequestResponseModel.fromJson(response.data);
  }

  Future<GetReceivedRequestResponseModel> getReceivedRequest() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "friendship/requests/received",
    );
    return GetReceivedRequestResponseModel.fromJson(response.data);
  }
}
