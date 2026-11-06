import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/auth_service.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/widgets/login_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Map<String, TextEditingController> _controllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };
  final Map<String, String> _errorMessages = {
    "email": "",
    "password": "",
    "default": "",
  };
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return LoginRegisterScreen(
      mode: AuthMode.login,
      onTap: () {
        _login(appLocalizations);
      },
      controllers: _controllers,
      errorMessages: _errorMessages,
      isLoginOrRegisterLoading: _isLoading,
      formKey: _formKey,
    );
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  Future<void> _login(AppLocalizations appLocalizations) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessages.updateAll((key, value) => "");
    });

    try {
      UserDm user = await AuthService().loginUserByEmailAndPassword(
        email: _controllers["email"]!.text.trim(),
        password: _controllers["password"]!.text.trim(),
      );

      if (!mounted) return;
      context.read<UserProvider>().setUser(user);
      Navigator.pushReplacement(context, AppRoutes.mainRoute());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
        case "invalid-credential":
          _errorMessages["default"] =
              appLocalizations.emailOrPasswordIsIncorrect;
          break;
        case "invalid-email":
          _errorMessages["email"] = appLocalizations.theEmailIsBadlyFormatted;
          break;
        case "user-disabled":
          _errorMessages["default"] =
              appLocalizations.thisAccountHasBeenDisabled;
          break;
        default:
          _errorMessages["default"] = appLocalizations.defaultErrorMessages;
          break;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _formKey.currentState?.validate();
      }
    }
  }
}
