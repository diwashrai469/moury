import 'dart:async';

import 'package:get/get.dart';
import 'package:moury/modules/data/register/models/check_username_response_model.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/base_model/base_model.dart';
import '../../../../data/register/models/register_view_response_models.dart';
import '../../../../data/register/repository/register_repository.dart';

class RegisterViewModel extends BaseModel {
  final IRegisterRepository _userRepository = RegisterRepository();
  RxString apiValidationStatus = ''.obs;

  String? fullNameValidation(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      return "Fullname is required!";
    }

    return null;
  }

  RxBool validationReady = false.obs; // Add this line

  String? userNameValidator(String? username) {
    if (username?.isEmpty == true) {
      return "Username cannot be empty";
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

  Future<bool> checkUsername({
    required String username,
  }) async {
    bool isOperationSuccessful = false;
    validationReady.value = false; // Add this line
    setLoading(true);

    var result = await _userRepository.checkUsername(
      username: username,
    );

    result.fold(
      (NetworkFailure error) {
        apiValidationStatus.value = error.message ?? '';
        update();
        ToastService().e(error.message.toString());
      },
      (CheckUserResponseModel data) {
        // Assuming there's a specific 'message' in CheckUserResponseModel to indicate success

        isOperationSuccessful = true;

        ToastService().s(data.message.toString());
      },
    );

    setLoading(false);
    update();

    return isOperationSuccessful;
  }
}
