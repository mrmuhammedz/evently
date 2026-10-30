import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/widgets/login_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Map<String, TextEditingController> controllers = {
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
      controllers: controllers,
      errorMessages: _errorMessages,
      isLoginOrRegisterLoading: _isLoading,
      formKey: _formKey,
    );
  }

  @override
  void dispose() {
    controllers.forEach((key, value) {
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
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: controllers["email"]!.text.trim(),
            password: controllers["password"]!.text,
          );

      UserDm user = UserDm(
        id: credential.user!.uid,
        name: controllers["name"]!.text.trim(),
        email: controllers["email"]!.text.trim(),
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .set(user.toJson());

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
