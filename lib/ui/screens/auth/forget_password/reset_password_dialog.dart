import 'dart:async';

import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/services/auth_service.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatefulWidget {
  final TextEditingController controller;

  const ResetPasswordDialog({super.key, required this.controller});

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  ThemeData get _theme => Theme.of(context);

  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: _isSuccess
          ? [
              Text(
                _appLocalizations.passwordResetLinkSent,
                style: AppStyles.mediumTextStyle16.copyWith(
                  color: AppColors.success,
                ),
              ),
            ]
          : [
              Text(
                _appLocalizations.enterVerifiedEmailAndSendResetLink,
                style: AppStyles.mediumTextStyle16.copyWith(
                  color: _theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EventlyTextFormField(
                      controller: widget.controller,
                      keyboardType: TextInputType.emailAddress,
                      hintText: _appLocalizations.enterYourEmail,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return _appLocalizations.pleaseEnterYourEmail;
                        }
                        if (!value.contains("@")) {
                          return _appLocalizations.pleaseEnterValidEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    AbsorbPointer(
                      absorbing: _isLoading,
                      child: Opacity(
                        opacity: _isLoading ? 0.6 : 1,
                        child: EventlyButton(
                          onPresses: _sendResetEmail,
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text(
                                  _appLocalizations.sendResetMail,
                                  style: AppStyles.mediumTextStyle20.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
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
                  ],
                ),
              ),
            ],
    );
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await AuthService()
          .resetPassword(widget.controller.text.trim())
          .timeout(const Duration(seconds: 30));

      if (!mounted) return;

      setState(() {
        _isSuccess = true;
        widget.controller.clear();
      });
    } on TimeoutException {
      if (!mounted) return;

      setState(() {
        _errorMessage = _appLocalizations.timedOut;
      });
    } on FirebaseAuthException catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage = _appLocalizations.defaultErrorMessages;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage = _appLocalizations.defaultErrorMessages;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
