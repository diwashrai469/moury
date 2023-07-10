import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moury/modules/data/my_community/services/my_community_services.dart';

import '../../../../core/services/network_services.dart';
import '../model/my_community_response_model.dart';

abstract class IMyCommunityRepository {
  Future<Either<NetworkFailure, MyCommunityResponseModel>> getCommunity(
      );
}

class MyCommunityRepository extends IMyCommunityRepository {
  @override
  Future<Either<NetworkFailure, MyCommunityResponseModel>> getCommunity(
  
  ) async {
    try {
      var result = await MyCommunityService().getMyCommunity();

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