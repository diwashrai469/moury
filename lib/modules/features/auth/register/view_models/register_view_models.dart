import 'package:get/get.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/base_model/base_model.dart';
import '../../../../data/register/models/register_view_response_models.dart';
import '../../../../data/register/repository/register_repository.dart';

class RegisterViewModel extends BaseModel {
  final IRegisterRepository _userRepository = RegisterRepository();

  String? fullName(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      return "Fullname is required!";
    }

    return null;
  }

  String? userNameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return "User name is required!";
    }
    return null;
  }

  String? emailvalidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required!";
    }

    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegExp.hasMatch(email)) {
      return "Invalid email format!";
    }
    return null;
  }

  String? passwordvalidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required!";
    }

    return null;
  }

  String? confirmPasswordval(String? confirmpassword) {
    if (confirmpassword == null || confirmpassword.isEmpty) {
      return "Confirm password is required!";
    }

    return null;
  }

  void registerUser({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    setLoading(true);
    var result = await _userRepository.registerUser(
        confirmPassword: confirmPassword,
        username: username,
        password: password,
        email: email,
        fullName: fullName);

    result.fold((NetworkFailure error) {
      ToastService().e(error.message ?? '');
    }, (RegisterViewResponseModels data) async {
      await LocalStorageService()
          .write(LocalStorageKeys.accessToken, data.accessToken);
      ToastService().s(data.status.toString());

      Get.offAndToNamed("/dashboard");
    });

    setLoading(false);
  }
}
