import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/widgets/evently_dialog.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:evently/ui/widgets/theme_dropdown.dart';
import 'package:evently/ui/widgets/user_image.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final languageProvider = context.watch<LanguageProvider>();
    final currentLocale = languageProvider.locale;
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 32),
          UserImage(radius: 54, user: user),
          SizedBox(height: 16),
          Text(
            user?.name ?? appLocalizations.guest,
            style: AppStyles.semiBoldTextStyle20.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            textAlign: .center,
          ),
          SizedBox(height: 4),
          Text(
            user?.email ?? "",
            style: AppStyles.regularTextStyle14.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: .center,
          ),
          SizedBox(height: 32),
          optionRow(
            theme: theme,
            text: appLocalizations.profile,
            action: SvgAsset(
              asset: currentLocale == "en"
                  ? AppIcons.arrowRight
                  : AppIcons.arrowLeft,
              color: theme.primaryColor,
            ),
            onTap: () {
              // Handle profile option tap
            },
          ),
          SizedBox(height: 16),
          optionRow(
            theme: theme,
            text: appLocalizations.myEvents,
            action: SvgAsset(
              asset: currentLocale == "en"
                  ? AppIcons.arrowRight
                  : AppIcons.arrowLeft,
              color: theme.primaryColor,
            ),
            onTap: () => Navigator.push(context, AppRoutes.myEvents()),
          ),
          SizedBox(height: 16),
          optionRow(
            theme: theme,
            text: appLocalizations.theme,
            action: ThemeDropdown(
              appLocalizations: appLocalizations,
              themeProvider: themeProvider,
            ),
          ),
          SizedBox(height: 16),
          optionRow(
            theme: theme,
            text: appLocalizations.language,
            action: Text(
              currentLocale == "en"
                  ? appLocalizations.english
                  : appLocalizations.arabic,
              style: AppStyles.mediumTextStyle16.copyWith(
                color: theme.primaryColor,
              ),
            ),
            onTap: () {
              final newLocale = currentLocale == "en" ? "ar" : "en";
              languageProvider.setLocale(newLocale);
            },
          ),
          SizedBox(height: 16),
          optionRow(
            theme: theme,
            text: appLocalizations.logout,
            action: SvgPicture.asset(AppIcons.logout),
            onTap: () => logoutDialog(
              context,
              appLocalizations: appLocalizations,
              theme: theme,
              userProvider: userProvider,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> logoutDialog(
    BuildContext context, {
    required AppLocalizations appLocalizations,
    required ThemeData theme,
    required UserProvider userProvider,
  }) async {
    final confirm = await eventlyShowDialog(
      context,
      title: appLocalizations.logout,
      content:  Text(
        appLocalizations.logoutConfirmation,
        style: AppStyles.mediumTextStyle16.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      cancel: appLocalizations.cancel,
      confirm: appLocalizations.confirm,
    );

    if (!context.mounted) return;
    if (confirm == true) {
      userProvider.logout();
      Navigator.pushReplacement(context, AppRoutes.loginRoute());
    }
  }

  Widget optionRow({
    required String text,
    required Widget action,
    Function()? onTap,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline),
          color: theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            Text(
              text,
              style: AppStyles.mediumTextStyle16.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
            Spacer(),
            action,
          ],
        ),
      ),
    );
  }
}
