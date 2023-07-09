import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:moury/modules/data/common/base_model.dart';

class DashboardViewModel extends BaseModel {
  RxInt selectedIndex = 0.obs;
  PageController pageController=PageController();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex.value = newSelectedIndex;
    pageController.jumpToPage(newSelectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
