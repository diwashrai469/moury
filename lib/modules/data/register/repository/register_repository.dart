import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/register/services/register_services.dart';
import '../../../../core/services/network_services.dart';
import '../models/check_username_response_model.dart';
import '../models/register_view_response_models.dart';

abstract class IRegisterRepository {
  Future<Either<NetworkFailure, RegisterViewResponseModels>> registerUser(
      {required String email,
      required String password,
      required String confirmPassword,
      required String fullName,
      required String username});

  Future<Either<NetworkFailure, CheckUserResponseModel>> checkUsername(
      {required String username});
}

class RegisterRepository extends IRegisterRepository {
  @override
  Future<Either<NetworkFailure, RegisterViewResponseModels>> registerUser(
      {required String email,
      required String password,
      required String username,
      required String confirmPassword,
      required String fullName}) async {
    try {
      var result = await RegisterService().userRegistration(
          email: email,
          username: username,
          password: password,
          confirmPassword: confirmPassword,
          fullName: fullName);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, CheckUserResponseModel>> checkUsername({
    required String username,
  }) async {
    try {
      var result = await RegisterService().checkUsername(
        username: username,
      );
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
