import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/chat/my_community/model/leave_community_response_model.dart';
import 'package:moury/modules/data/chat/my_community/services/my_community_services.dart';

import '../../../../../core/services/network_services.dart';
import '../model/my_community_response_model.dart';

abstract class IMyCommunityRepository {
  Future<Either<NetworkFailure, MyCommunityResponseModel>> getMyCommunity();
  Future<Either<NetworkFailure, MyCommunityResponseModel>> sendMessage(
      {required String id, required String message});
  Future<Either<NetworkFailure, LeaveCommunityResponseModel>> leaveCommmunity({
    required String id,
  });
}

class MyCommunityRepository extends IMyCommunityRepository {
  @override
  Future<Either<NetworkFailure, MyCommunityResponseModel>>
      getMyCommunity() async {
    try {
      print("called");
      var result = await MyCommunityService().getMyCommunity();

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, MyCommunityResponseModel>> sendMessage(
      {required String id, required String message}) async {
    try {
      var result =
          await MyCommunityService().sendMessage(id: id, message: message);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, LeaveCommunityResponseModel>> leaveCommmunity({
    required String id,
  }) async {
    try {
      var result = await MyCommunityService().leaveMyCommunity(id);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
