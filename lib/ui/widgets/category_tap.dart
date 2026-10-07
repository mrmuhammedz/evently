import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  final String icon;
  final String selectedIcon;
  final bool isSelected;

  const CategoryTab({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedIcon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainColor : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? null : Border.all(color: AppColors.stroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          SvgPicture.asset(
            isSelected ? selectedIcon : icon,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.white : AppColors.mainColor,
              BlendMode.srcIn,
            ),
            height: 24,
          ),
          Text(
            selectLanguage(title, appLocalizations)!,
            style: isSelected
                ? AppStyles.white16medium
                : AppStyles.mainText16medium,
          ),
        ],
      ),
    );
  }

  String? selectLanguage(String title, AppLocalizations appLocalizations) {
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
    return null;
  }
}
