import 'dart:async';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/screens/auth/forget_password/reset_password_dialog.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_dialog.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _mailController = TextEditingController();
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return EventlyScaffold(
      child: Column(
        children: [
          SizedBox(height: 16),
          EventlyHeader(
            center: Text(
              _appLocalizations.forgetPassword2,
              style: AppStyles.mediumTextStyle18.copyWith(
                color: _theme.colorScheme.onSecondary,
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
                color: _theme.colorScheme.onSurface,
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
                      color: _theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 40),
                  EventlyButton(
                    onPresses: () => onPress(),
                    child: Text(
                      _appLocalizations.resetPassword,
                      style: AppStyles.mediumTextStyle20.copyWith(
                        color: AppColors.white,
                      ),
                    ),
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

  @override
  void dispose() {
    _mailController.dispose();
    super.dispose();
  }

  Future<void> onPress() async {
    await eventlyShowDialog(
      context,
      title: _appLocalizations.resetYourPassword,
      content: ResetPasswordDialog(controller: _mailController),
    );
  }
}
