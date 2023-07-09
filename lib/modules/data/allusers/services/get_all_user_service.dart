import 'package:dio/dio.dart';
import 'package:moury/modules/data/allusers/model/all_users_response_model.dart';
import 'package:moury/modules/data/allusers/model/follow_response_model.dart';
import 'package:moury/modules/data/allusers/model/send_friend_request_response_model.dart';
import '../../../../core/services/intercepters.dart';

class GetAllFriendServices {
  Future<AllUsersResponseModel> getAllUsers() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "profile",
    );
    return AllUsersResponseModel.fromJson(response.data);
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

  Future<FollowResponseModel> checkFollow(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "follow/check/$userId",
    );
    return FollowResponseModel.fromJson(response.data);
  }

  Future<FollowResponseModel> followUser(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.post("follow", data: {"user_id": userId});
    return FollowResponseModel.fromJson(response.data);
  }

  Future<FollowResponseModel> unFollowUser(String userId) async {
    Dio dio = getDioInstance();

    final response = await dio.delete(
      "follow/$userId",
    );
    return FollowResponseModel.fromJson(response.data);
  }
}
