import 'package:dio/dio.dart';
import '../../../../core/services/intercepters.dart';
import '../models/login_view_response_models.dart';

class LoginService {
  Future<LoginResponseModel> userLogin(String userName, String password) async {
    Dio dio = getDioInstance();

    final response = await dio.post(
      "users/login",
      data: {
        'username': userName,
        'password': password,
      },
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
