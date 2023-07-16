import 'package:flutter/material.dart';
import 'package:moury/common/constant/app_dimens.dart';

class KMaterialButton extends StatelessWidget {
  const KMaterialButton(
      {Key? key,
      required this.text,
      this.color,
      this.textColor,
      required this.onKeyPressed,
      this.height})
      : super(key: key);
  final String text;
  final Color? color;
  final double? height;
  final Color? textColor;
  final void Function()? onKeyPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
          AppDimens.globalCircularRadius,
          ),
          side: BorderSide(color: Colors.grey.shade400)),
      color: color,
      height: height,
      minWidth: 5,
      onPressed: onKeyPressed,
      child: Text(
          textAlign: TextAlign.center,
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600, color: textColor)),
    );
  }
}