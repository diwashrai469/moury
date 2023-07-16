import 'dart:async';

import 'package:moury/modules/data/base_model/base_model.dart';

import '../../../../core/services/local_storage.dart';
import '../../../../core/services/network_services.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/user_config/models/user_config_response_models.dart';
import '../../../data/user_config/respository/user_config_repository.dart';

class ConfigViewModel extends BaseModel {
  @override
  void onInit() {
    super.onInit();

    getConfigTimePeriodic();
  }

  IUserConfigRepository configRepository = UserConfigRepository();

  void getConfigTimePeriodic() {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        String? token =
            LocalStorageService().read(LocalStorageKeys.accessToken);
        if (token == null) {
          return;
        }
        try {
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
              print("config is called");
            },
          );
        } catch (err) {
          print(err);
        }
      },
    );
  }
}
