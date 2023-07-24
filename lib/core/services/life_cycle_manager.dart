import 'package:flutter/material.dart';
import 'package:get/get.dart';

//this is for not getting notification when user is using app.
class LifeCycleManager extends GetxController with WidgetsBindingObserver {
  static LifeCycleManager get to => Get.find();
  var isAppInForeground = true.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        isAppInForeground.value = true;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        isAppInForeground.value = false;
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }
}
