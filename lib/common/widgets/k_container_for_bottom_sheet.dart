import 'package:flutter/material.dart';

Widget kContainerForBottomSheet() {
  return Center(
    child: Container(
      height: 6,
      width: 70,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  );
}
