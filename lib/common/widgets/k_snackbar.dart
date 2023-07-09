import 'package:flutter/material.dart';
import 'package:get/get.dart';

void kSnackbar(String? title, String message, bool isSuccess) {
  Get.snackbar(title ?? '', message,
      colorText: Colors.white,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.easeInOut,
      margin: const EdgeInsets.all(10),
      isDismissible: true,
      duration: const Duration(milliseconds: 1500),
      icon: isSuccess == true
          ? const Icon(
              Icons.check_box,
              color: Colors.white,
            )
          : const Icon(
              Icons.close,
              color: Colors.white,
            ),
      dismissDirection: DismissDirection.down);
}
