import 'package:dio/dio.dart';
import 'package:moury/modules/data/register/models/check_username_response_model.dart';
import '../../../../core/services/intercepters.dart';
import '../models/register_view_response_models.dart';

class RegisterService {
  Future<RegisterViewResponseModels> userRegistration({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    Dio dio = getDioInstance();

    final response = await dio.post(
      "users/register",
      data: {
        'name': fullName,
        "username": username,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword
      },
    );
    return RegisterViewResponseModels.fromJson(response.data);
  }

  Future<CheckUserResponseModel> checkUsername({
    required String username,
  }) async {
    Dio dio = getDioInstance();

    final response = await dio.post(
      "users/checkUsername",
      data: {
        "username": username,
      },
    );
    return CheckUserResponseModel.fromJson(response.data);
  }
}
