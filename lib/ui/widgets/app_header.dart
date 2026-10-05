import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final Widget? leading;
  final Widget center;
  final List<Widget>? actions;

  const AppHeader({super.key, this.leading, required this.center, this.actions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (leading != null)
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: leading,
            ),
          center,
          if (actions != null && actions!.isNotEmpty)
            Align(
              alignment: AlignmentGeometry.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}
