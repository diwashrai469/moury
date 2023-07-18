import 'package:flutter/material.dart';
import 'package:moury/theme/app_theme.dart';

class KListtile extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Widget? subtitile;
  final void Function()? onKeyPressed;

  const KListtile(
      {super.key, this.icon,this.subtitile, required this.text, this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        leading: Icon(
          icon,
          size: 30,
        ),
        title: TextButton(
          style: const ButtonStyle(alignment: Alignment.centerLeft),
          onPressed: onKeyPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: secondaryColor),
          ),
        ),
        subtitle: subtitile,
      ),
    );
  }
}
