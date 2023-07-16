import 'package:dartz/dartz.dart';

import '../../../../core/services/network_services.dart';
import '../models/explore_view_response_model.dart';
import '../services/explore__services.dart';

abstract class IExploreRepository {
  Future<Either<NetworkFailure, ExploreResponseModel>> getExplore();
}

class ExploreRepository extends IExploreRepository {
  @override
  Future<Either<NetworkFailure, ExploreResponseModel>> getExplore() async {
    try {
      var result = await ExploreService().getExplores();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
