import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventlyButton extends StatelessWidget {
  final Widget child;
  final Function onPresses;
  final String? prefixIcon;
  final Color backgroundColor;

  const EventlyButton({
    super.key,
    required this.child,
    required this.onPresses,
    this.prefixIcon,
    this.backgroundColor = AppColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(double.infinity, 48),
        side: BorderSide(
          color: prefixIcon == null ? Colors.transparent : AppColors.stroke,
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
          child
        ],
      ),
    );
  }
}
