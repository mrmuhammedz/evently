import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/services/auth_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return EventlyScaffold(
      child: Column(
        children: [
          const SizedBox(height: 16),
          screenHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    currentPasswordField(),
                    const SizedBox(height: 25),
                    newPasswordField(),
                    const SizedBox(height: 25),
                    confirmNewPasswordField(),
                    const SizedBox(height: 25),
                    updateButton(),
                    if (_errorMessage != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: AppStyles.regularTextStyle14.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                    const SizedBox(height: 25),
                    passwordRequirements(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  EventlyHeader screenHeader() {
    return EventlyHeader(
      center: Text(
        _appLocalizations.changePassword,
        style: AppStyles.mediumTextStyle18.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      leading: ButtonWidget(
        onTap: () => Navigator.pop(context),
        child: SvgAsset(
          asset: Localizations.localeOf(context).languageCode == "en"
              ? AppIcons.arrowLeft
              : AppIcons.arrowRight,
          color: _theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget currentPasswordField() {
    return textFieldContainer(
      label: _appLocalizations.currentPassword,
      hintText: _appLocalizations.enterCurrentPassword,
      textInputAction: TextInputAction.next,
      controller: _currentPasswordController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return _appLocalizations.passwordMustBeAtLeast6Characters;
        }
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainUppercase;
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainLowercase;
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainNumber;
        }
        return null;
      },
    );
  }

  Widget newPasswordField() {
    return textFieldContainer(
      label: _appLocalizations.newPassword,
      hintText: _appLocalizations.enterNewPassword,
      textInputAction: TextInputAction.next,
      controller: _newPasswordController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return _appLocalizations.passwordMustBeAtLeast6Characters;
        }
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainUppercase;
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainLowercase;
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainNumber;
        }
        return null;
      },
    );
  }

  Widget confirmNewPasswordField() {
    return textFieldContainer(
      label: _appLocalizations.confirmNewPassword,
      hintText: _appLocalizations.enterConfirmNewPassword,
      textInputAction: TextInputAction.done,
      controller: _confirmPasswordController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _appLocalizations.pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return _appLocalizations.passwordMustBeAtLeast6Characters;
        }
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainUppercase;
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainLowercase;
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return _appLocalizations.passwordMustContainNumber;
        }
        if (value != _newPasswordController.text) {
          return _appLocalizations.passwordsDontMatch;
        }
        return null;
      },
    );
  }

  Widget passwordRequirements() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _newPasswordController,
      builder: (_, value, _) {
        final password = value.text;
        final hasMinLength = password.length >= 6;
        final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
        final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
        final hasNumber = RegExp(r'[0-9]').hasMatch(password);

        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: _theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _theme.colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _appLocalizations.passwordRequirements,
                style: AppStyles.mediumTextStyle16.copyWith(
                  color: _theme.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              requirementRow(
                _appLocalizations.atLeast6Characters,
                hasMinLength,
              ),
              const SizedBox(height: 4),
              requirementRow(
                _appLocalizations.atLeastOneUppercaseLetter,
                hasUppercase,
              ),
              const SizedBox(height: 4),
              requirementRow(
                _appLocalizations.atLeastOneLowercaseLetter,
                hasLowercase,
              ),
              const SizedBox(height: 4),
              requirementRow(_appLocalizations.atLeastOneNumber, hasNumber),
            ],
          ),
        );
      },
    );
  }

  Row requirementRow(String title, bool isValid) {
    final color = isValid ? AppColors.success : AppColors.red;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyles.regularTextStyle14.copyWith(color: color),
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.circle, size: 10, color: color),
      ],
    );
  }

  Widget textFieldContainer({
    required String label,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: [
      Text(
        label,
        style: AppStyles.mediumTextStyle16.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      EventlyTextFormField(
        keyboardType: textInputType,
        validator: validator,
        textInputAction: textInputAction,
        hintText: hintText,
        controller: controller,
        suffixIcon: AppIcons.eye,
        suffixIconInactive: AppIcons.eyeSlash,
        obscureText: true,
      ),
    ],
  );

  Widget updateButton() {
    return EventlyButton(
      onPresses: _onUpdatePassword,
      child: _isLoading
          ? CircularProgressIndicator(color: AppColors.white)
          : Text(
              _appLocalizations.updatePassword,
              style: AppStyles.mediumTextStyle20.copyWith(
                color: AppColors.white,
              ),
            ),
    );
  }

  Future<void> _onUpdatePassword() async {
    if (_isLoading) return;

    if (!_key.currentState!.validate()) return;

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    try {
      await _authService.reauthenticateWithPassword(currentPassword);

      await _authService.updatePassword(newPassword);

      if (!mounted) return;

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
          _errorMessage = _appLocalizations.currentPasswordIsIncorrect;
        } else {
          _errorMessage = _appLocalizations.defaultErrorMessages;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
