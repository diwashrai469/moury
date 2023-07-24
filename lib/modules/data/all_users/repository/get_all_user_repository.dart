import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/all_users/model/all_users_response_model.dart';
import 'package:moury/modules/data/all_users/model/follow_response_model.dart';
import 'package:moury/modules/data/all_users/model/friend_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/get_received_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/get_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/my_friends_response_model.dart';
import 'package:moury/modules/data/all_users/model/send_friend_request_response_model.dart';

import '../../../../core/services/network_services.dart';
import '../services/get_all_user_service.dart';

abstract class IGetAllUsersRepository {
  Future<Either<NetworkFailure, AllUsersResponseModel>> getAllUser();
  Future<Either<NetworkFailure, MyFriendsResponseModel>> myFriends();
  Future<Either<NetworkFailure, GetRequestResponseModel>> getRequest();
  Future<Either<NetworkFailure, GetReceivedRequestResponseModel>>
      getReceivedRequest();
  Future<Either<NetworkFailure, AllUsersResponseModel>> getSingleUser(
      String userid);
  Future<Either<NetworkFailure, SendFriendResonseModel>> sendFriendRequest(
      String friendRequestId);
  Future<Either<NetworkFailure, CheckFriendResponseModel>> checkIsFriend(
      String userid);
  Future<Either<NetworkFailure, FriendRequestResponseModel>> addUser(
      String userid);
  Future<Either<NetworkFailure, FriendRequestResponseModel>> deleteSentRequest(
      String userid);
  Future<Either<NetworkFailure, FriendRequestResponseModel>> acceptUser(
      String userid);
  Future<Either<NetworkFailure, FriendRequestResponseModel>> rejectRequest(
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
  Future<Either<NetworkFailure, MyFriendsResponseModel>> myFriends() async {
    try {
      var result = await GetAllFriendServices().myFriends();

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
  Future<Either<NetworkFailure, CheckFriendResponseModel>> checkIsFriend(
      String userid) async {
    try {
      var result = await GetAllFriendServices().checkIsFriend(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FriendRequestResponseModel>> addUser(
      String userid) async {
    try {
      var result = await GetAllFriendServices().addUser(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FriendRequestResponseModel>> acceptUser(
      String userid) async {
    try {
      var result = await GetAllFriendServices().acceptUser(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FriendRequestResponseModel>> deleteSentRequest(
      String userid) async {
    try {
      var result = await GetAllFriendServices().deleteSentRequest(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, FriendRequestResponseModel>> rejectRequest(
      String userid) async {
    try {
      var result = await GetAllFriendServices().rejectRequest(userid);

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, GetRequestResponseModel>> getRequest() async {
    try {
      var result = await GetAllFriendServices().getRequest();

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, GetReceivedRequestResponseModel>>
      getReceivedRequest() async {
    try {
      var result = await GetAllFriendServices().getReceivedRequest();

      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
