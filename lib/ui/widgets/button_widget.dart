import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final double radius;
  final Function? onTap;
  final Widget child;
  final Widget? icon;
  final Color bgColor;

  const ButtonWidget({
    super.key,
    this.horizontalPadding = 4,
    this.verticalPadding = 4,
    this.radius = 8,
    this.bgColor = AppColors.white,
    this.onTap,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColorTheme = bgColor == AppColors.white ? theme.colorScheme.surface : bgColor;

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () => onTap?.call(),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: bgColorTheme == theme.primaryColor
              ? null
              : Border.all(color: theme.colorScheme.outline),
          color: bgColorTheme,
        ),
        child: Row(
          spacing: 8,
          mainAxisSize: icon == null ? MainAxisSize.min : MainAxisSize.max,
          children: icon == null ? [child] : [Expanded(child: child), ?icon],
        ),
      ),
    );
  }
}
