import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/all_community/models/all_community_response_model.dart';
import 'package:moury/modules/data/all_community/services/all_community_services.dart';
import '../../../../core/services/network_services.dart';
import '../models/join_community.dart';

abstract class IAllCommunityRepository {
  Future<Either<NetworkFailure, AllCommunityResponseModel>> getAllCommunity();
  Future<Either<NetworkFailure, JoinCommunityResponseModel>> joinCommunity(
      String communityId);
  Future<Either<NetworkFailure, AllCommunityResponseModel>> getSingleCommunity(
      String id);
}

class AllCommunityRepository extends IAllCommunityRepository {
  @override
  Future<Either<NetworkFailure, AllCommunityResponseModel>>
      getAllCommunity() async {
    try {
      var result = await AllCommunityService().getAllCommunity();

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, JoinCommunityResponseModel>> joinCommunity(
      String communityId) async {
    try {
      var result = await AllCommunityService().joinCommunity(communityId);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, AllCommunityResponseModel>> getSingleCommunity(
      String id) async {
    try {
      var result = await AllCommunityService().getSingleCommunity(id);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
