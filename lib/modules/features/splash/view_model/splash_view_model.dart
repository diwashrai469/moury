import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/user_config/models/user_config_response_models.dart';

import '../../../../core/services/local_storage.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/user_config/respository/user_config_repository.dart';

class SplashViewModel extends BaseModel {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        checkAccessToken();
      },
    );
  }

  IUserConfigRepository configRepository = UserConfigRepository();

  void checkAccessToken() {
    String? accessToken =
        LocalStorageService().read(LocalStorageKeys.accessToken);
    print(accessToken);
    if (accessToken == null || accessToken.isEmpty) {
      Get.offNamed('/login');
    } else {
      Get.offNamed('/dashboard');
      getConfig();
    }
  }

  void getConfig() async {
    setLoading(true);

    var result = await configRepository.getUserConfig();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (UserConfigResponseModel data) async {
        await LocalStorageService()
            .write(LocalStorageKeys.accessToken, data.accessToken);
      },
    );
    setLoading(false);
  }
}
