import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/user_config/models/user_config_response_models.dart';

import '../../../../core/services/local_storage.dart';
import '../../../../core/services/push_notification.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/user_config/respository/user_config_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
      final decodedToken = JwtDecoder.decode(accessToken.toString());
      print(decodedToken['_id']);
      PushNotificationService().initialise(
          topics: ["${decodedToken["_id"]}_PRIVATE_CHAT", "PRIVATE_CHAT"]);

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
        print("config failed");
        String? accessToken =
            LocalStorageService().read(LocalStorageKeys.accessToken);
        final decodedToken = JwtDecoder.decode(accessToken.toString());
        PushNotificationService().unsubscribe(
            ["${decodedToken["_id"]}_PRIVATE_CHAT", "PRIVATE_CHAT"]);
      },
      (UserConfigResponseModel data) async {
        await LocalStorageService()
            .write(LocalStorageKeys.accessToken, data.accessToken);
      },
    );
    setLoading(false);
  }
}
