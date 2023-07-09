import 'package:flutter/material.dart';
import '../common/constant/app_dimens.dart';

const fontFamily = "Belanosima";
const avatarBackgroundColor = Color.fromRGBO(91, 91, 91, 91);

const disabledColor = Color(0xFFbcbcbc);
const primaryColor = Color.fromARGB(255, 233, 140, 0);
const lightPrimaryCplor = Color(0xFFa0a6ff);
const secondaryColor = Color(0xFF282724);
const shutleGrey = Color(0xFFf4f4f4);
final errorColor = Colors.red.shade300;
const successColor = Color(0xFF00da9f);
const warningColor = Color(0xFFfce8bb);
const warningIconColor = Color(0xFFf3b31c);
const darkGrey = Color(0xFF5b5b5b);
const lightGrey = Color(0xFFf3f6f9);
const chipGrey = Color(0xFFe1e1e1);
const cursorColor = Color(0xFF666666);
const bodyColor = Color(0xFF000000);
const buttonColor = Color(0xFFFFFFFF);
const inputSuffixIconClor = Color(0xFF6dd819);
const containerColor = Color.fromARGB(255, 234, 238, 243);

// const errorBorder = OutlineInputBorder(
//   borderRadius: AppDimens.inputBorderRadius,
//   borderSide: BorderSide(
//     color: errorColor,
//   ),
// );

// const enabledBorder = OutlineInputBorder(
//   borderRadius: AppDimens.inputBorderRadius,
//   borderSide: BorderSide(
//     color: disabledColor,
//   ),
// );

// const focusedBorder = OutlineInputBorder(
//   borderRadius: AppDimens.inputBorderRadius,
//   borderSide: BorderSide(
//     color: darkGrey,
//   ),
// );

abstract class AppThemes {
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    errorColor: errorColor,
    textSelectionTheme: ThemeData.light().textSelectionTheme.copyWith(
          cursorColor: cursorColor,
        ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(
          bodyColor: bodyColor,
          fontFamily: fontFamily,
        )
        .copyWith(
          bodyMedium: ThemeData.light().textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: AppDimens.bodyFontSize,
              fontFamily: fontFamily,
              letterSpacing: 0.9),
        ),
    // inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
    //       contentPadding: AppDimens.inputPadding,
    //       fillColor: Colors.white,
    //       enabledBorder: enabledBorder,
    //       focusedBorder: focusedBorder,
    //       errorBorder: errorBorder,
    //       focusedErrorBorder: errorBorder,
    //       iconColor: darkGrey,
    //     ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    cardTheme: ThemeData.light().cardTheme.copyWith(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
        color: const Color(0xFFFFFFFF)),
  );
}
