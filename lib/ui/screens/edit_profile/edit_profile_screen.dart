import 'dart:async';

import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/auth_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:evently/ui/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _mailController;
  late final UserDm _user;
  final _authService = AuthService();
  final _key = GlobalKey<FormState>();
  String? _errorMessage;
  bool _isSuccessMessage = false;
  bool _hasPasswordProvider = false;
  bool _isGoogleUser = false;
  bool _isLoading = false;
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  UserProvider get _userProvider => context.read<UserProvider>();
  ThemeData get _theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
    _user = _userProvider.user!;
    _nameController = TextEditingController(text: _user.name);
    _mailController = TextEditingController(text: _user.email);

    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _isGoogleUser = currentUser.providerData.any(
        (provider) => provider.providerId == 'google.com',
      );
      _hasPasswordProvider = currentUser.providerData.any(
        (provider) => provider.providerId == 'password',
      );
    }
  }

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
              child: Column(
                children: [
                  SizedBox(height: 16),
                  UserImage(radius: 75, user: _user),
                  SizedBox(height: 16),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        nameField(),
                        const SizedBox(height: 16),
                        emailField(),
                        const SizedBox(height: 16),
                        passwordField(),
                        const SizedBox(height: 32),
                        saveButton(),
                        if (_errorMessage != null) ...[
                          SizedBox(height: 8),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: AppStyles.regularTextStyle14.copyWith(
                              color: _isSuccessMessage
                                  ? AppColors.success
                                  : AppColors.red,
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
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
    _nameController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  EventlyHeader screenHeader() {
    return EventlyHeader(
      center: Text(
        _appLocalizations.editProfile,
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

  Widget nameField() {
    return textFieldContainer(
      label: _appLocalizations.fullName,
      hintText: _appLocalizations.enterYourName,
      controller: _nameController,
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

  Widget emailField() {
    return textFieldContainer(
      absorbing: _isGoogleUser,
      label: _appLocalizations.emailAddress,
      hintText: _appLocalizations.enterYourEmail,
      controller: _mailController,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
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

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _appLocalizations.password,
          style: AppStyles.mediumTextStyle16.copyWith(
            color: _theme.colorScheme.onSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _appLocalizations.changeYourAccountPassword,
          style: AppStyles.regularTextStyle14.copyWith(
            color: _theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        AbsorbPointer(
          absorbing: !_hasPasswordProvider,
          child: Opacity(
            opacity: !_hasPasswordProvider ? 0.4 : 1,
            child: ButtonWidget(
              horizontalPadding: 16,
              verticalPadding: 8,
              radius: 16,
              onTap: () =>
                  Navigator.push(context, AppRoutes.editPasswordRoute()),
              icon: SvgAsset(
                asset: Localizations.localeOf(context).languageCode == "en"
                    ? AppIcons.arrowRight
                    : AppIcons.arrowLeft,
                color: _theme.colorScheme.onSurface,
              ),
              child: Text(
                _appLocalizations.changePassword,
                style: AppStyles.regularTextStyle20.copyWith(
                  color: _theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget saveButton() {
    return EventlyButton(
      onPresses: _onSaveProfile,
      child: _isLoading
          ? CircularProgressIndicator(color: AppColors.white)
          : Text(
              _appLocalizations.saveChanges,
              style: AppStyles.mediumTextStyle20.copyWith(
                color: AppColors.white,
              ),
            ),
    );
  }

  Future<void> _onSaveProfile() async {
    if (_isLoading) return;
    if (!_key.currentState!.validate()) return;

    setState(() {
      _errorMessage = null;
      _isSuccessMessage = false;
      _isLoading = true;
    });

    final newName = _nameController.text.trim();
    final newEmail = _mailController.text.trim();

    try {
      bool emailNeedsVerification = (newEmail != _user.email);
      if (emailNeedsVerification) {
        await _authService.updateEmail(newEmail);
      }
      await _authService
          .updateProfileData(uid: _user.id, newName: newName)
          .timeout(const Duration(seconds: 20));

      _user.name = newName;
      _userProvider.setUser(_user);

      String message = emailNeedsVerification
          ? _appLocalizations.nameUpdatedVerificationSent
          : _appLocalizations.dataUpdatedSuccessfully;
      setState(() {
        _isSuccessMessage = true;
        _errorMessage = message;
      });
    } on TimeoutException {
      setState(() {
        _isSuccessMessage = false;
        _errorMessage = _appLocalizations.timedOut;
      });
    } catch (e) {
      setState(() {
        _isSuccessMessage = false;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget textFieldContainer({
    required String label,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    bool absorbing = false,
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
      AbsorbPointer(
        absorbing: absorbing,
        child: Opacity(
          opacity: absorbing ? 0.4 : 1,
          child: EventlyTextFormField(
            keyboardType: textInputType,
            validator: validator,
            textInputAction: textInputAction,
            hintText: hintText,
            controller: controller,
          ),
        ),
      ),
    ],
  );
}
