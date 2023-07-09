import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/login/models/login_view_response_models.dart';
import 'package:moury/modules/data/login/services/login_services.dart';
import '../../../../core/services/network_services.dart';

abstract class ILoginRepository {
  Future<Either<NetworkFailure, LoginResponseModel>> loginUser(
      {required String password, required String username});
}

class RegisterRepository extends ILoginRepository {
  @override
  Future<Either<NetworkFailure, LoginResponseModel>> loginUser({
    required String password,
    required String username,
  }) async {
    try {
      var result = await LoginService().userLogin(username, password);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
