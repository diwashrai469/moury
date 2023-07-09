import 'package:dartz/dartz.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/modules/data/user_config/models/user_config_response_models.dart';
import 'package:moury/modules/data/user_config/services/user_config_services.dart';

abstract class IUserConfigRepository {
  Future<Either<NetworkFailure, UserConfigResponseModel>> getUserConfig();
}

class UserConfigRepository extends IUserConfigRepository {
  @override
  Future<Either<NetworkFailure, UserConfigResponseModel>>
      getUserConfig() async {
    try {
      var result = await UserConfigServices().getUserConfig();

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
