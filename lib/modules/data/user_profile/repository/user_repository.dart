import 'package:dartz/dartz.dart';

import '../../../../core/services/network_services.dart';
import '../models/user_edit_reponse_model.dart';
import '../services/user_services.dart';

abstract class IUserRepository {
  Future<Either<NetworkFailure, UserEditResponseModel>> editUserProfile(
      {required String profilePicture, String? username});
}

class UserRepository extends IUserRepository {
  @override
  Future<Either<NetworkFailure, UserEditResponseModel>> editUserProfile({
    required String profilePicture,
    String? username,
  }) async {
    try {
      var result = await UserServices().editUser(profilePicture, username);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
