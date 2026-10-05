import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventlyButton extends StatelessWidget {
  final String text;
  final Function() onPresses;
  final String? prefixIcon;

  const EventlyButton({
    super.key,
    required this.text,
    required this.onPresses,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        backgroundColor: prefixIcon == null
            ? AppColors.mainColor
            : AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(double.infinity, 48),
        side: BorderSide(
          color: prefixIcon == null
              ? Colors.transparent
              : AppColors.stroke,
        ),
      ),
      onPressed: onPresses,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[Image.asset(prefixIcon!,), SizedBox(width: 16)],
          Text(
            text,
            style: prefixIcon == null
                ? AppStyles.white20medium
                : AppStyles.mainColor18medium,
          ),
        ],
      ),
    );
  }
}
