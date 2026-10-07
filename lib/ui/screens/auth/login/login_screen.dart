import 'package:evently/ui/widgets/login_register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginRegisterScreen(mode: AuthMode.login,);
  }
}
