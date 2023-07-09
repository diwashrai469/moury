import 'package:dio/dio.dart';
import 'package:moury/core/services/intercepters.dart';
import 'package:moury/modules/data/user_config/models/user_config_response_models.dart';

class UserConfigServices {
  Future<UserConfigResponseModel> getUserConfig() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "users/config",
    );
    return UserConfigResponseModel.fromJson(response.data);
  }
}
