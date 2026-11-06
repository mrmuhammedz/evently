import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventlyButton extends StatelessWidget {
  final Widget child;
  final Function onPresses;
  final String? prefixIcon;
  final Color bgColor;

  const EventlyButton({
    super.key,
    required this.child,
    required this.onPresses,
    this.prefixIcon,
    this.bgColor = AppColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColorTheme = bgColor == AppColors.mainColor
        ? theme.primaryColor
        : bgColor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        backgroundColor: bgColorTheme,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(double.infinity, 48),
        side: BorderSide(
          color: prefixIcon == null
              ? Colors.transparent
              : theme.colorScheme.outline,
        ),
      ),
      onPressed: () {
        onPresses();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            Image.asset(prefixIcon!),
            SizedBox(width: 16),
          ],
          child,
        ],
      ),
    );
  }
}
