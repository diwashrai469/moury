import 'package:flutter/material.dart';
import 'package:moury/theme/app_theme.dart';

Widget kContainerForBottomSheet() {
  return Center(
    child: Container(
      height: 6,
      width: 70,
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  );
}
