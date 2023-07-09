import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moury/modules/data/common/base_model.dart';

import '../../../../core/services/local_storage.dart';

class SplashViewModel extends BaseModel {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAccessToken();
    });
  }

  void checkAccessToken() {
    String? accessToken =
        LocalStorageService().read(LocalStorageKeys.accessToken);
    print(accessToken);
    if (accessToken == null || accessToken.isEmpty) {
      Get.offNamed('/login');
    } else {
      Get.offNamed('/dashboard');
    }
  }
}
