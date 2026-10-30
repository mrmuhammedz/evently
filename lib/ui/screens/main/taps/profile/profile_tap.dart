import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/widgets/user_image.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_switch.dart';
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
    final currentLocale = languageProvider.locale.languageCode;
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 32),
        UserImage(radius: 54, user: user),
        SizedBox(height: 16),
        Text(
          user?.name ?? appLocalizations.guest,
          style: AppStyles.mainText20semiBold,
          textAlign: .center,
        ),
        SizedBox(height: 4),
        Text(
          user?.email ?? "",
          style: AppStyles.secText14regular,
          textAlign: .center,
        ),
        SizedBox(height: 32),
        optionRow(
          text: appLocalizations.profile,
          action: SvgPicture.asset(
            currentLocale == "en" ? AppIcons.arrowRight : AppIcons.arrowLeft,
          ),
          onTap: () {
            // Handle profile option tap
          },
        ),
        SizedBox(height: 16),
        optionRow(
          text: appLocalizations.darkMode,
          action: EventlySwitch(value: false),
          onTap: () {
            // Handle dark mode option tap
          },
        ),
        SizedBox(height: 16),
        optionRow(
          text: appLocalizations.language,
          action: Text(
            currentLocale == "en"
                ? appLocalizations.english
                : appLocalizations.arabic,
            style: AppStyles.mainColor16medium,
          ),
          onTap: () {
            final newLocale = currentLocale == "en"
                ? const Locale("ar")
                : const Locale("en");
            languageProvider.setLocale(newLocale);
          },
        ),
        SizedBox(height: 16),
        optionRow(
          text: appLocalizations.logout,
          action: SvgPicture.asset(AppIcons.logout),
          onTap: () => logoutDialog(
            context: context,
            appLocalizations: appLocalizations,
            userProvider: userProvider,
          ),
        ),
      ],
    );
  }

  Future<dynamic> logoutDialog({
    required BuildContext context,
    required AppLocalizations appLocalizations,
    required UserProvider userProvider,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(appLocalizations.logout),
          content: Text(appLocalizations.logoutConfirmation, style: AppStyles.mainText16medium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              
              child: Text(appLocalizations.cancel, style: AppStyles.mainColor14semiBold),
            ),
            TextButton(
              onPressed: () {
                userProvider.logout();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(context, AppRoutes.loginRoute());
              },
              child: Text(appLocalizations.confirm, style: AppStyles.mainColor14semiBold),
            ),
          ],
        );
      },
    );
  }

  Widget optionRow({
    required String text,
    required Widget action,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.stroke),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Text(text, style: AppStyles.mainText16medium),
            Spacer(),
            action,
          ],
        ),
      ),
    );
  }
}
