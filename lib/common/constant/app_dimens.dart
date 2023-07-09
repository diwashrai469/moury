import 'package:flutter/material.dart';

/// App Dimensions class to reuse values that are used throughout the layout
/// Using a single source of dimensions will create robust ui development,
/// and also make design changes easier.

class AppDimens {
  static const mainPagePadding = EdgeInsets.only(
    right: 25,
    left: 25,
    top: 5,
  );
  static const typeMessageContainerPadding =
      EdgeInsets.symmetric(horizontal: 10, vertical: 20);

  static const pagePadding = EdgeInsets.all(20);
  static const pagePaddingX = EdgeInsets.symmetric(horizontal: 20);
  static const pagePaddingY = EdgeInsets.symmetric(vertical: 20);
  static const pagePaddingLarge = EdgeInsets.all(32);

  static const cardRadius = 0.0;
  static const cardBorderRadius = BorderRadius.all(Radius.circular(cardRadius));
  static const double cardPaddingSize = 20;
  static const cardPadding = EdgeInsets.all(cardPaddingSize);
  static const inputBorderRadius = BorderRadius.all(Radius.circular(0));
  static const inputPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const chipPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
  static const buttonFontSizeXSmall = 14.0;
  static const buttonFontSizeSmall = 15.0;
  static const buttonFontSizeMedium = 16.0;
  static const buttonFontSizeLarge = 17.0;

  static const iconButtonSizeSmall = 24.0;
  static const iconButtonSizeLarge = 32.0;

//boarder radius
  static const sboarderRadisCircular = 8.0;

  static const buttonPaddingXSmall =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const buttonPaddingSmall =
      EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  static const buttonPaddingMedium =
      EdgeInsets.symmetric(horizontal: 22, vertical: 16);
  static const buttonPaddingLarge =
      EdgeInsets.symmetric(horizontal: 32, vertical: 24);

  static const double bodyFontSize = 15;

  static const FontWeight mfontweigt = FontWeight.w600;

  static const double headlineFontSizeXXXSmall = 10;
  static const double headlineFontSizeXXSmall = 12;
  static const double headlineFontSizeXSmall = 14;
  static const double headlineFontSizeSmall = 16;
  static const double headlineFontSizeOther = 18;
  static const double headlineFontSizeMedium = 28;
  static const double headlineFontSizeLarge = 36;

  static const double multiSelectPadding = 8;
}
