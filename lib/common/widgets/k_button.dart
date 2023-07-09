import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../constant/app_dimens.dart';
import '../constant/ui_helpers.dart';

enum ButtonSize { small, medium, large, xSmall }

class KButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final ButtonSize size;
  final bool isBusy;
  final bool? bordered;
  final Color? backgroundColor, foregroundColor;
  @override
  const KButton({
    required this.child,
    required this.onPressed,
    this.isBusy = false,
    this.size = ButtonSize.small,
    this.backgroundColor,
    this.foregroundColor,
    this.bordered,
    Key? key,
  }) : super(key: key);

  double getFontSizeBySize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xSmall:
        return AppDimens.buttonFontSizeXSmall;
      case ButtonSize.small:
        return AppDimens.buttonFontSizeSmall;
      case ButtonSize.medium:
        return AppDimens.buttonFontSizeMedium;
      case ButtonSize.large:
        return AppDimens.buttonFontSizeLarge;
    }
  }

  EdgeInsetsGeometry getPaddingBySize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xSmall:
        return AppDimens.buttonPaddingXSmall;
      case ButtonSize.small:
        return AppDimens.buttonPaddingSmall;
      case ButtonSize.medium:
        return AppDimens.buttonPaddingMedium;
      case ButtonSize.large:
        return AppDimens.buttonPaddingLarge;
    }
  }

  double getProgressRadiusByButtonSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xSmall:
        return 16;
      case ButtonSize.small:
        return 18;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 22;
    }
  }

  double getProgressWidthByButtonSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xSmall:
        return 2;
      case ButtonSize.small:
        return 2;
      case ButtonSize.medium:
        return 3;
      case ButtonSize.large:
        return 3;
    }
  }

  /// Button is wrapped inside of theme to change the font-size of the
  /// child text widget based on the size passed.
  ///
  /// The buttons can be wrapped to fit content by Wrapping it inside of Row,
  /// and setting the mainAxisSize: MainAxisSize.min

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: getFontSizeBySize(size),
                  ),
            ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: getPaddingBySize(size),
          shape: RoundedRectangleBorder(
            side: (bordered ?? false)
                ? const BorderSide(color: Colors.black12)
                : BorderSide.none,
            borderRadius:const  BorderRadius.all(
              Radius.circular(AppDimens.sboarderRadisCircular),
            ),
          ),
        ).copyWith(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return foregroundColor ?? buttonColor;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return (backgroundColor ?? Theme.of(context).primaryColor)
                    .withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return (backgroundColor ?? Theme.of(context).primaryColor)
                    .withOpacity(0.5);
              } else {
                return (backgroundColor ?? Theme.of(context).primaryColor);
              }
            },
          ),
        ),
        onPressed: isBusy ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBusy)
              Row(
                children: [
                  SizedBox(
                    width: getProgressRadiusByButtonSize(size),
                    height: getProgressRadiusByButtonSize(size),
                    child: CircularProgressIndicator(
                      strokeWidth: getProgressWidthByButtonSize(size),
                    ),
                  ),
                  lWidthSpan,
                ],
              )
            else
              child,
          ],
        ),
      ),
    );
  }
}
