import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return EventlyScaffold(
      child: Column(
        children: [
          SizedBox(height: 16),
          EventlyHeader(
            center: Text(
              appLocalizations.forgetPassword2,
              style: AppStyles.mediumTextStyle18.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
            leading: ButtonWidget(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgAsset(
                asset: Localizations.localeOf(context).languageCode == "en"
                    ? AppIcons.arrowLeft
                    : AppIcons.arrowRight,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    height: 343,
                    child: ImageIcon(
                      AssetImage(AppImages.changeSetting),
                      size: double.infinity,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 40),
                  EventlyButton(
                    child: Text(
                      appLocalizations.resetPassword,
                      style: AppStyles.mediumTextStyle20.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    onPresses: () {},
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
