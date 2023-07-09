import 'package:flutter/material.dart';
import 'package:get/get.dart';

kButtonsheet(
  Widget widget,
  String name,
  void Function() onpressed,
) {
  Get.bottomSheet(
    backgroundColor: Colors.grey,
    Wrap(
      children: [
        ListTile(
          leading: widget,
          onTap: () => onpressed,
        ),
        ListTile(leading: widget, onTap: () => onpressed)
      ],
    ),
  );
}
