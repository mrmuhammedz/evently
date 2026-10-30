import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool get _isBusy => widget.isLoginOrRegisterLoading || _isGoogleLoading;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isRegister = widget.mode == AuthMode.register;
    final buttonText = isRegister
        ? appLocalizations.signUp
        : appLocalizations.login;

    return EventlyScaffold(
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SizedBox(height: 16),
              Image.asset(AppImages.logo),
              SizedBox(height: 48),
              Text(
                isRegister
                    ? appLocalizations.createYourAccount
                    : appLocalizations.loginToYourAccount,
                style: AppStyles.mainColor24semiBold,
              ),
              SizedBox(height: 24),
              if (isRegister) ...[
                nameField(appLocalizations),
                SizedBox(height: 16),
              ],
              emailField(appLocalizations),
              SizedBox(height: 16),
              passwordField(appLocalizations),
              if (isRegister) ...[
                SizedBox(height: 16),
                confirmPasswordField(appLocalizations),
                SizedBox(height: 4),
              ],
              if (!isRegister) ...[
                SizedBox(height: 8),
                forgetPasswordButton(context, appLocalizations),
              ],
              SizedBox(height: 47),
              loginRegisterButton(buttonText),
              if (widget.errorMessages["default"]!.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  widget.errorMessages["default"]!,
                  textAlign: TextAlign.center,
                  style: AppStyles.red14regular,
                ),
                SizedBox(height: 8),
              ],
              SizedBox(height: 48),
              loginRegisterSwitchButton(isRegister, appLocalizations, context),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1, color: AppColors.stroke),
                  ),
                  SizedBox(width: 16),
                  Text(appLocalizations.or, style: AppStyles.mainColor16medium),
                  SizedBox(width: 16),
                  Expanded(
                    child: Divider(thickness: 1, color: AppColors.stroke),
                  ),
                ],
              ),
              SizedBox(height: 24),
              loginRegisterWithGoogleButton(appLocalizations, isRegister),
            ],
          ),
        ),
      ),
    );
  }

  AbsorbPointer loginRegisterWithGoogleButton(
    AppLocalizations appLocalizations,
    bool isRegister,
  ) {
    return AbsorbPointer(
      absorbing: _isBusy,
      child: Opacity(
        opacity: widget.isLoginOrRegisterLoading ? 0.6 : 1,
        child: EventlyButton(
          backgroundColor: AppColors.white,
          onPresses: () {
            _onTapGoogle(appLocalizations);
          },
          prefixIcon: _isGoogleLoading ? null : AppImages.google,
          child: _isGoogleLoading
              ? CircularProgressIndicator(color: AppColors.mainColor)
              : Text(
                  isRegister
                      ? appLocalizations.signUpWithGoogle
                      : appLocalizations.loginWithGoogle,
                  style: AppStyles.mainColor18medium,
                ),
        ),
      ),
    );
  }

  Row loginRegisterSwitchButton(
    bool isRegister,
    AppLocalizations appLocalizations,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRegister
              ? appLocalizations.alreadyHaveAnAccount
              : appLocalizations.dontHaveAnAccount,
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
    );
  }

  AbsorbPointer loginRegisterButton(String buttonText) {
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
              : Text(buttonText, style: AppStyles.white20medium),
        ),
      ),
    );
  }

  Align forgetPasswordButton(
    BuildContext context,
    AppLocalizations appLocalizations,
  ) {
    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, AppRoutes.forgetPasswordRoute());
        },
        child: Text(
          appLocalizations.forgetPassword1,
          style: AppStyles.mainColor14semiBold.copyWith(decoration: .underline),
        ),
      ),
    );
  }

  EventlyTextFormField confirmPasswordField(AppLocalizations appLocalizations) {
    return EventlyTextFormField(
      hintText: appLocalizations.confirmYourPassword,
      prefixIcon: AppIcons.lock,
      suffixIcon: AppIcons.eyeSlash,
      suffixIconActive: AppIcons.eye,
      controller: widget.controllers["confirmPassword"],
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return appLocalizations.pleaseEnterYourPassword;
        }
        if (value != widget.controllers["password"]!.text) {
          return appLocalizations.passwordsDontMatch;
        }
        return null;
      },
    );
  }

  EventlyTextFormField passwordField(AppLocalizations appLocalizations) {
    return EventlyTextFormField(
      hintText: appLocalizations.enterYourPassword,
      prefixIcon: AppIcons.lock,
      suffixIcon: AppIcons.eyeSlash,
      suffixIconActive: AppIcons.eye,
      obscureText: true,
      controller: widget.controllers["password"],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return appLocalizations.pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return appLocalizations.passwordMustBeAtLeast6Characters;
        }
        return null;
      },
    );
  }

  EventlyTextFormField emailField(AppLocalizations appLocalizations) {
    return EventlyTextFormField(
      hintText: appLocalizations.enterYourEmail,
      prefixIcon: AppIcons.sms,
      controller: widget.controllers["email"],
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (widget.errorMessages["email"] != null &&
            widget.errorMessages["email"]!.isNotEmpty) {
          final error = widget.errorMessages["email"];
          widget.errorMessages["email"] = "";
          return error;
        }
        if (value == null || value.trim().isEmpty) {
          return appLocalizations.pleaseEnterYourEmail;
        }
        if (!value.contains("@")) {
          return appLocalizations.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }

  EventlyTextFormField nameField(AppLocalizations appLocalizations) {
    return EventlyTextFormField(
      hintText: appLocalizations.enterYourName,
      prefixIcon: AppIcons.user,
      controller: widget.controllers["name"],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return appLocalizations.pleaseEnterYourName;
        }
        if (value.trim().length < 2) {
          return appLocalizations.nameMustBeAtLeast2Characters;
        }
        return null;
      },
    );
  }

  Future<void> _onTapGoogle(AppLocalizations appLocalizations) async {
    if (_isBusy) return;

    setState(() {
      _isGoogleLoading = true;
      widget.errorMessages["default"] = "";
    });

    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      late UserDm user;
      final userDoc = FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid);
      final userSnapshot = await userDoc.get();

      if (userSnapshot.exists && userSnapshot.data() != null) {
        user = UserDm.fromJson(userSnapshot.data()!);
      } else {
        user = UserDm(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? "",
          email: userCredential.user!.email ?? "",
          photoUrl: userCredential.user!.photoURL,
        );
        await userDoc.set(user.toJson());
      }

      if (!mounted) return;
      context.read<UserProvider>().setUser(user);
      if (Navigator.canPop(context)) Navigator.pop(context);
      Navigator.pushReplacement(context, AppRoutes.mainRoute());
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      setState(() {
        widget.errorMessages["default"] = appLocalizations.unableToSignUp;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        widget.errorMessages["default"] = switch (e.code) {
          "account-exists-with-different-credential" =>
            appLocalizations.thisAccountAlreadyExists,
          "invalid-credential" => appLocalizations.invalidGoogleCredentials,
          "operation-not-allowed" => appLocalizations.googleSignInIsNotEnabled,
          "user-disabled" => appLocalizations.thisAccountHasBeenDisabled,
          _ => appLocalizations.defaultErrorMessages,
        };
      });
    } catch (e) {
      setState(() {
        widget.errorMessages["default"] = appLocalizations.defaultErrorMessages;
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
