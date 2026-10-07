import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWidget extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final Function() onTap;
  final Widget child;
  final String? icon;
  final Color bgColor;

  const ButtonWidget({
    super.key,
    this.horizontalPadding = 4,
    this.verticalPadding = 4,
    this.bgColor = AppColors.white,
    required this.onTap,
    required this.child,
    this.icon,
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
          border: bgColor == AppColors.mainColor
              ? null
              : Border.all(color: AppColors.stroke),
          color: bgColor,
        ),
        child: Row(
          spacing: 8,
          mainAxisSize: icon == null ? MainAxisSize.min : MainAxisSize.max,
          children: icon == null
              ? [child]
              : [
                  Expanded(child: child),
                  GestureDetector(onTap: () {}, child: SvgPicture.asset(icon!)),
                ],
        ),
      ),
    );
  }
}
