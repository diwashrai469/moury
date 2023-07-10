import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moury/modules/data/all_community/models/all_community_response_model.dart';
import 'package:moury/modules/data/all_community/services/all_community_services.dart';
import '../../../../core/services/network_services.dart';
import '../models/join_community.dart';

abstract class IAllCommunityRepository {
  Future<Either<NetworkFailure, AllCommunityResponseModel>> getAllCommunity(
      );
      Future<Either<NetworkFailure, JoinCommunityResponseModel>> joinCommunity(String communityId
      );
}

class AllCommunityRepository extends IAllCommunityRepository {
  @override
  Future<Either<NetworkFailure, AllCommunityResponseModel>> getAllCommunity(
  
  ) async {
    try {
      var result = await AllCommunityService().getAllCommunity();

      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type,
          error: e.error,
        ));
      } else {
        return Left(NetworkFailure(
          requestOptions: RequestOptions(path: "community"),
        ));
      }
    }
  }

  @override
  Future<Either<NetworkFailure, JoinCommunityResponseModel>> joinCommunity(String communityId
  
  ) async {
    try {
      var result = await AllCommunityService().joinCommunity(communityId);

      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type,
          error: e.error,
        ));
      } else {
        return Left(NetworkFailure(
          requestOptions: RequestOptions(path: "community"),
        ));
      }
    }
  }
}