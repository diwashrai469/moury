import 'package:dio/dio.dart';
import 'package:moury/modules/data/userprofile/models/user_edit_reponse_model.dart';

import '../../../../core/services/intercepters.dart';

class UserServices {
  Future<UserEditResponseModel> editUser(String profilePicture, String? name) async {
    Dio dio = getDioInstance();

    final response = await dio.patch(
      "users/profile",
      data: {
        'profile_picture': profilePicture,
        'name': name,
      },
    );
    return UserEditResponseModel.fromJson(response.data);
  }
}