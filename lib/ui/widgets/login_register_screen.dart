import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_text_field.dart';
import 'package:flutter/material.dart';

enum AuthMode { login, register }

class LoginRegisterScreen extends StatelessWidget {
  final AuthMode mode;
  const LoginRegisterScreen({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isRegister = mode == AuthMode.register;
    final buttonText = isRegister ? appLocalizations.signUp : appLocalizations.login;

    return EventlyScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            SizedBox(height: 16),
            Image.asset(AppImages.logo),
            SizedBox(height: 48),
            Text(
              isRegister ? appLocalizations.createYourAccount : appLocalizations.loginToYourAccount,
              style: AppStyles.mainColor24semiBold,
            ),
            SizedBox(height: 24),
            if (isRegister) ...[
              EventlyTextField(
                hintText: appLocalizations.enterYourName,
                prefixIcon: AppIcons.user,
              ),
              SizedBox(height: 16),
            ],
            EventlyTextField(
              hintText: appLocalizations.enterYourEmail,
              prefixIcon: AppIcons.sms,
            ),
            SizedBox(height: 16),
            EventlyTextField(
              hintText: appLocalizations.enterYourPassword,
              prefixIcon: AppIcons.lock,
              suffixIcon: AppIcons.eyeSlash,
              obscureText: true,
            ),
            if (isRegister) ...[
              SizedBox(height: 16),
              EventlyTextField(
                hintText: appLocalizations.confirmYourPassword,
                prefixIcon: AppIcons.lock,
                suffixIcon: AppIcons.eyeSlash,
                obscureText: true,
              ),
              SizedBox(height: 4),
            ],
            if (!isRegister) ...[
              SizedBox(height: 8),
              GestureDetector(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, AppRoutes.forgetPasswordRoute());
                  },
                  child: Text(
                    appLocalizations.forgotPassword,
                    style: AppStyles.mainColor14semiBold.copyWith(
                      decoration: .underline,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
            SizedBox(height: 47),
            EventlyButton(text: buttonText, onPresses: () {}),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isRegister ? appLocalizations.alreadyHaveAnAccount : appLocalizations.dontHaveAnAccount,
                  style: AppStyles.secText14regular,
                ),
                GestureDetector(
                  onTap: () {
                    isRegister
                        ? Navigator.pop(context)
                        : Navigator.push(context, AppRoutes.signUpRoute());
                  },
                  child: Text(
                    isRegister ? appLocalizations.login : appLocalizations.signUp,
                    style: AppStyles.mainColor14semiBold.copyWith(
                      decoration: .underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: Divider(thickness: 1, color: AppColors.stroke)),
                SizedBox(width: 16),
                Text(appLocalizations.or, style: AppStyles.mainColor16medium),
                SizedBox(width: 16),
                Expanded(child: Divider(thickness: 1, color: AppColors.stroke)),
              ],
            ),
            SizedBox(height: 24),
            EventlyButton(
              text: isRegister ? appLocalizations.signUpWithGoogle : appLocalizations.loginWithGoogle,
              onPresses: () {},
              prefixIcon: AppImages.google,
            ),
          ],
        ),
      ),
    );
  }
}
