import 'package:evently/services/auth_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widgets/login_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Map<String, TextEditingController> _controllers = {
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };
  final Map<String, String> _errorMessages = {
    "name": "",
    "email": "",
    "password": "",
    "confirmPassword": "",
    "default": "",
  };
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return LoginRegisterScreen(
      mode: AuthMode.register,
      onTap: () {
        _register(appLocalizations);
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

  Future<void> _register(AppLocalizations appLocalizations) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessages.updateAll((key, value) => "");
    });

    try {
      await AuthService().createUserWithEmailAndPassword(
        name: _controllers["name"]!.text,
        email: _controllers["email"]!.text,
        password: _controllers["password"]!.text,
      );

      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          _errorMessages["email"] = appLocalizations.theAccountAlreadyExists;
          break;
        case "invalid-email":
          _errorMessages["email"] = appLocalizations.theEmailIsBadlyFormatted;
          break;
        case "weak-password":
          _errorMessages["password"] =
              appLocalizations.passwordMustBeAtLeast6Characters;
          break;
        default:
          _errorMessages["default"] = appLocalizations.defaultErrorMessages;
          break;
      }
    } on FirebaseException catch (e) {
      _errorMessages["default"] = "Error: ${e.message}";
    } catch (e) {
      _errorMessages["default"] = "Unexpected error: $e";
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
