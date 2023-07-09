import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/allusers/model/all_users_response_model.dart';
import 'package:moury/modules/data/allusers/model/follow_response_model.dart';
import 'package:moury/modules/data/allusers/model/send_friend_request_response_model.dart';

import '../../../../core/services/network_services.dart';
import '../services/get_all_user_service.dart';

abstract class IGetAllUsersRepository {
  Future<Either<NetworkFailure, AllUsersResponseModel>> getAllUser();
  Future<Either<NetworkFailure, AllUsersResponseModel>> getSingleUser(
      String userid);
  Future<Either<NetworkFailure, SendFriendResonseModel>> sendFriendRequest(
      String friendRequestId);
  Future<Either<NetworkFailure, FollowResponseModel>> checkFollow(
      String userid);
  Future<Either<NetworkFailure, FollowResponseModel>> followUser(String userid);
  Future<Either<NetworkFailure, FollowResponseModel>> unfollowUser(
      String userid);
}

class GetAllUserRepository extends IGetAllUsersRepository {
  @override
  Future<Either<NetworkFailure, AllUsersResponseModel>> getAllUser() async {
    try {
      var result = await GetAllFriendServices().getAllUsers();

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, SendFriendResonseModel>> sendFriendRequest(
      String friendRequestId) async {
    try {
      var result =
          await GetAllFriendServices().sendFriendRequest(friendRequestId);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, AllUsersResponseModel>> getSingleUser(
      String userid) async {
    try {
      var result = await GetAllFriendServices().getSingleUser(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FollowResponseModel>> checkFollow(
      String userid) async {
    try {
      var result = await GetAllFriendServices().checkFollow(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FollowResponseModel>> followUser(
      String userid) async {
    try {
      var result = await GetAllFriendServices().followUser(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FollowResponseModel>> unfollowUser(
      String userid) async {
    try {
      var result = await GetAllFriendServices().unFollowUser(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
