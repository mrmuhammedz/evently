import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final Function() onTap;
  final Widget child;

  const ButtonWidget({
    super.key,
    this.horizontalPadding = 4,
    this.verticalPadding = 4,
    required this.onTap, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.stroke),
            color: AppColors.white,
          ),
        child: child,
      ),
    );
  }
}
