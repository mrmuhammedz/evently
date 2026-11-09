import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/screens/add_event/add_event_screen.dart';
import 'package:evently/ui/screens/event_details/event_details_screen.dart';
import 'package:evently/ui/screens/onboarding/onboarding_screen.dart';
import 'package:evently/ui/screens/auth/login/login_screen.dart';
import 'package:evently/ui/screens/auth/sign_up/sign_up_screen.dart';
import 'package:evently/ui/screens/auth/forget_password/forget_password_screen.dart';
import 'package:evently/ui/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute onBoardingRoute() =>
      MaterialPageRoute(builder: (_) => const OnboardingScreen());
  static MaterialPageRoute loginRoute() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  static MaterialPageRoute signUpRoute() =>
      MaterialPageRoute(builder: (_) => const SignUpScreen());
  static MaterialPageRoute forgetPasswordRoute() =>
      MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
  static MaterialPageRoute mainRoute() =>
      MaterialPageRoute(builder: (_) => const MainScreen());
  static MaterialPageRoute addEventRoute() =>
      MaterialPageRoute(builder: (_) => const AddEventScreen());
  static MaterialPageRoute eventDetailsRoute({
    required EventDm event,
    required String heroTag,
  }) => MaterialPageRoute(
    builder: (_) => EventDetailsScreen(event: event, heroTag: heroTag),
  );
}
