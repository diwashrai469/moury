import 'package:get/get.dart';
import 'package:moury/modules/data/login/models/login_view_response_models.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/base_model/base_model.dart';
import '../../../../data/login/repository/login_repository.dart';

class LoginViewModel extends BaseModel {

  String? userNameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return "username is required!";
    }

    return null;
  }

  String? passwordvalidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required!";
    }

    return null;
  }

  ILoginRepository userRepository = RegisterRepository();
  void loginUser(String username, String password) async {
    setLoading(true);

    var result =
        await userRepository.loginUser(password: password, username: username);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (LoginResponseModel data) async {
        await LocalStorageService()
            .write(LocalStorageKeys.accessToken, data.accessToken);
           

        Get.offAndToNamed("/splash");
        ToastService().s(data.message);
      },
    );
    setLoading(false);
  }

  
}
