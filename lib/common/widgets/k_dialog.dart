import 'package:flutter/material.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/theme/app_theme.dart';

import 'k_material_button.dart';

Future<void> kDialogBox(
  BuildContext context, {
  String? message,
  final void Function()? onKeyPressed,
  final String? heading,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (heading != null)
                    Text(
                      heading,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  lHeightSpan,
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      message ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14, color: secondaryColor),
                    ),
                  ),
                  lHeightSpan,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      KMaterialButton(
                          textColor: secondaryColor,
                          color: Colors.white,
                          onKeyPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Cancel"),
                      mWidthSpan,
                      KMaterialButton(
                          textColor: Colors.white,
                          color: primaryColor,
                          onKeyPressed: onKeyPressed,
                          text: "Confirm")
                    ],
                  ),
                  sHeightSpan,
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
