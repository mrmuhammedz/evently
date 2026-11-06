import 'package:evently/services/auth_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum AuthMode { login, register }

class LoginRegisterScreen extends StatefulWidget {
  final AuthMode mode;
  final Function onTap;
  final Map<String, TextEditingController> controllers;
  final Map<String, String> errorMessages;
  final bool isLoginOrRegisterLoading;
  final GlobalKey<FormState> formKey;

  const LoginRegisterScreen({
    super.key,
    required this.mode,
    required this.onTap,
    required this.controllers,
    required this.errorMessages,
    this.isLoginOrRegisterLoading = false,
    required this.formKey,
  });

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool _isGoogleLoading = false;
  late final _isRegister = widget.mode == AuthMode.register;
  bool get _isBusy => widget.isLoginOrRegisterLoading || _isGoogleLoading;
  ThemeData get _theme => Theme.of(context);
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final buttonText = _isRegister
        ? _appLocalizations.signUp
        : _appLocalizations.login;

    return EventlyScaffold(
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SizedBox(height: 16),
              ImageIcon(
                AssetImage(AppImages.logo),
                size: 26,
                color: _theme.primaryColor,
              ),
              SizedBox(height: 48),
              Text(
                _isRegister
                    ? _appLocalizations.createYourAccount
                    : _appLocalizations.loginToYourAccount,
                style: AppStyles.mainColor24semiBold,
              ),
              SizedBox(height: 24),
              if (_isRegister) ...[nameField(), SizedBox(height: 16)],
              emailField(),
              SizedBox(height: 16),
              passwordField(),
              if (_isRegister) ...[
                SizedBox(height: 16),
                confirmPasswordField(),
                SizedBox(height: 4),
              ],
              if (!_isRegister) ...[
                SizedBox(height: 8),
                forgetPasswordButton(),
              ],
              SizedBox(height: 47),
              loginRegisterButton(buttonText),
              if (widget.errorMessages["default"]!.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  widget.errorMessages["default"]!,
                  textAlign: TextAlign.center,
                  style: AppStyles.regularTextStyle14.copyWith(
                    color: AppColors.red,
                  ),
                ),
                SizedBox(height: 8),
              ],
              SizedBox(height: 48),
              loginRegisterSwitchButton(),
              SizedBox(height: 32),
              dividerRow(),
              SizedBox(height: 24),
              loginRegisterWithGoogleButton(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Row dividerRow() {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 1, color: _theme.colorScheme.outline),
        ),
        SizedBox(width: 16),
        Text(
          _appLocalizations.or,
          style: AppStyles.mediumTextStyle16.copyWith(
            color: _theme.primaryColor,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Divider(thickness: 1, color: _theme.colorScheme.outline),
        ),
      ],
    );
  }

  AbsorbPointer loginRegisterWithGoogleButton() {
    return AbsorbPointer(
      absorbing: _isBusy,
      child: Opacity(
        opacity: widget.isLoginOrRegisterLoading ? 0.6 : 1,
        child: EventlyButton(
          bgColor: _theme.colorScheme.surface,
          onPresses: () {
            _onTapGoogle();
          },
          prefixIcon: _isGoogleLoading ? null : AppImages.google,
          child: _isGoogleLoading
              ? CircularProgressIndicator(color: _theme.primaryColor)
              : Text(
                  _isRegister
                      ? _appLocalizations.signUpWithGoogle
                      : _appLocalizations.loginWithGoogle,
                  style: AppStyles.mediumTextStyle18,
                ),
        ),
      ),
    );
  }

  Row loginRegisterSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isRegister
              ? _appLocalizations.alreadyHaveAnAccount
              : _appLocalizations.dontHaveAnAccount,
          style: AppStyles.regularTextStyle14.copyWith(
            color: _theme.colorScheme.onSurfaceVariant,
          ),
        ),
        GestureDetector(
          onTap: () {
            _isRegister
                ? Navigator.pop(context)
                : Navigator.push(context, AppRoutes.signUpRoute());
          },
          child: Text(
            _isRegister ? _appLocalizations.login : _appLocalizations.signUp,
            style: AppStyles.semiBoldTextStyle14.copyWith(
              decoration: .underline,
              color: _theme.primaryColor,
              decorationColor: _theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget loginRegisterButton(String buttonText) {
    return AbsorbPointer(
      absorbing: _isBusy,
      child: Opacity(
        opacity: _isGoogleLoading ? 0.6 : 1,
        child: EventlyButton(
          onPresses: () {
            if (_isBusy) return;
            if (!widget.formKey.currentState!.validate()) return;
            widget.onTap();
          },
          child: widget.isLoginOrRegisterLoading
              ? CircularProgressIndicator(color: AppColors.white)
              : Text(
                  buttonText,
                  style: AppStyles.mediumTextStyle20.copyWith(
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Align forgetPasswordButton() {
    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, AppRoutes.forgetPasswordRoute());
        },
        child: Text(
          _appLocalizations.forgetPassword1,
          style: AppStyles.semiBoldTextStyle14.copyWith(
            decoration: .underline,
            color: _theme.primaryColor,
            decorationColor: _theme.primaryColor,
          ),
        ),
      ),
    );
  }

  EventlyTextFormField confirmPasswordField() {
    return EventlyTextFormField(
      label: _appLocalizations.confirmYourPassword,
      prefixIcon: AppIcons.lock,
      suffixIcon: AppIcons.eye,
      suffixIconColor: AppColors.disable,
      suffixIconInactive: AppIcons.eyeSlash,
      controller: widget.controllers["confirmPassword"],
      obscureText: true,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourPassword;
        }
        if (value != widget.controllers["password"]!.text) {
          return _appLocalizations.passwordsDontMatch;
        }
        return null;
      },
    );
  }

  EventlyTextFormField passwordField() {
    return EventlyTextFormField(
      label: _appLocalizations.enterYourPassword,
      prefixIcon: AppIcons.lock,
      suffixIcon: AppIcons.eye,
      suffixIconColor: AppColors.disable,
      suffixIconInactive: AppIcons.eyeSlash,
      obscureText: true,
      textInputAction: _isRegister
          ? TextInputAction.next
          : TextInputAction.done,
      controller: widget.controllers["password"],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return _appLocalizations.passwordMustBeAtLeast6Characters;
        }
        return null;
      },
    );
  }

  EventlyTextFormField emailField() {
    return EventlyTextFormField(
      label: _appLocalizations.enterYourEmail,
      prefixIcon: AppIcons.sms,
      controller: widget.controllers["email"],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (widget.errorMessages["email"] != null &&
            widget.errorMessages["email"]!.isNotEmpty) {
          final error = widget.errorMessages["email"];
          widget.errorMessages["email"] = "";
          return error;
        }
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourEmail;
        }
        if (!value.contains("@")) {
          return _appLocalizations.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }

  EventlyTextFormField nameField() {
    return EventlyTextFormField(
      label: _appLocalizations.enterYourName,
      prefixIcon: AppIcons.user,
      controller: widget.controllers["name"],
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourName;
        }
        if (value.trim().length < 2) {
          return _appLocalizations.nameMustBeAtLeast2Characters;
        }
        return null;
      },
    );
  }

  Future<void> _onTapGoogle() async {
    if (_isBusy) return;

    setState(() {
      _isGoogleLoading = true;
      widget.errorMessages["default"] = "";
    });

    try {
      UserDm user = await AuthService().createUserByGoogle().timeout(
        const Duration(seconds: 30),
      );

      if (!mounted) return;
      context.read<UserProvider>().setUser(user);
      if (Navigator.canPop(context)) Navigator.pop(context);
      Navigator.pushReplacement(context, AppRoutes.mainRoute());
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      setState(() {
        widget.errorMessages["default"] = _appLocalizations.unableToSignUp;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        widget.errorMessages["default"] = switch (e.code) {
          "account-exists-with-different-credential" =>
            _appLocalizations.thisAccountAlreadyExists,
          "invalid-credential" => _appLocalizations.invalidGoogleCredentials,
          "operation-not-allowed" => _appLocalizations.googleSignInIsNotEnabled,
          "user-disabled" => _appLocalizations.thisAccountHasBeenDisabled,
          _ => _appLocalizations.defaultErrorMessages,
        };
      });
    } catch (e) {
      setState(() {
        widget.errorMessages["default"] =
            _appLocalizations.defaultErrorMessages;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }
}
