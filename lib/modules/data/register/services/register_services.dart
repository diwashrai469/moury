import 'package:dio/dio.dart';
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
}
