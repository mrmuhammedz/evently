import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  final String selectedIcon;
  final String icon;
  final bool isSelected;

  const CategoryTab({
    super.key,
    required this.title,
    required this.selectedIcon,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.primaryColor : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          SvgAsset(
            asset: isSelected ? selectedIcon : icon,
            color: isSelected ? AppColors.white : theme.primaryColor,
            height: 24,
          ),
          Text(
            selectLanguage(title, appLocalizations),
            style: isSelected
                ? AppStyles.mediumTextStyle16.copyWith(color: AppColors.white)
                : AppStyles.mediumTextStyle16.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
          ),
        ],
      ),
    );
  }

  String selectLanguage(String title, AppLocalizations appLocalizations) {
    switch (title) {
      case "All":
        return appLocalizations.all;
      case "Sport":
        return appLocalizations.sport;
      case "Book Club":
        return appLocalizations.bookClub;
      case "Birthday":
        return appLocalizations.birthday;
      case "Meeting":
        return appLocalizations.meeting;
      case "Exhibition":
        return appLocalizations.exhibition;
    }
    return title;
  }
}
