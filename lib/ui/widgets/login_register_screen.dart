import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_text_field.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  login,
  register,
}

class LoginRegisterScreen extends StatelessWidget {
  final AuthMode mode;

  const LoginRegisterScreen({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final isRegister = mode == AuthMode.register;
    final buttonText = isRegister ? 'Sign up' : 'Login';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                SizedBox(height: 16),
                Image.asset(AppImages.logo),
                SizedBox(height: 48),
                Text('${isRegister ? 'Create' : 'Login to'} your account', style: AppStyles.mainColor24semiBold),
                SizedBox(height: 24),
                if (isRegister) ...[
                  EventlyTextField(
                    hintText: 'Enter your name',
                    prefixIcon: AppIcons.user,
                  ),
                  SizedBox(height: 16),
                ],
                EventlyTextField(
                  hintText: 'Enter your email',
                  prefixIcon: AppIcons.sms,
                ),
                SizedBox(height: 16),
                EventlyTextField(
                  hintText: 'Enter your password',
                  prefixIcon: AppIcons.lock,
                  suffixIcon: AppIcons.eyeSlash,
                  obscureText: true,
                ),
                if (isRegister) ...[
                  SizedBox(height: 16),
                  EventlyTextField(
                    hintText: 'Confirm your password',
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
                        Navigator.push(context, AppRoutes.forgetPasswordRoute(),
                        );
                      },
                      child: Text(
                        "Forgot password?",
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
                      "${isRegister ? "Already" : "Don’t"} have an account? ",
                      style: AppStyles.secText14regular,
                    ),
                    GestureDetector(
                      onTap: () {
                        isRegister
                            ? Navigator.pop(context)
                            : Navigator.push(context, AppRoutes.signUpRoute());
                      },
                      child: Text(
                        isRegister ? "Login" : "Sign up",
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
                    Expanded(
                      child: Divider(thickness: 1, color: AppColors.stroke),
                    ),
                    SizedBox(width: 16),
                    Text("Or", style: AppStyles.mainColor16medium),
                    SizedBox(width: 16),
                    Expanded(
                      child: Divider(thickness: 1, color: AppColors.stroke),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                EventlyButton(
                  text: "$buttonText with Google",
                  onPresses: () {},
                  prefixIcon: AppImages.google,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
