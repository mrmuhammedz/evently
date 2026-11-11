import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/screens/auth/forget_password/forget_password_screen.dart';
import 'package:evently/ui/screens/auth/login/login_screen.dart';
import 'package:evently/ui/screens/auth/sign_up/sign_up_screen.dart';
import 'package:evently/ui/screens/edit_profile/edit_password_screen.dart';
import 'package:evently/ui/screens/edit_profile/edit_profile_screen.dart';
import 'package:evently/ui/screens/event_details/event_details_screen.dart';
import 'package:evently/ui/screens/main/main_screen.dart';
import 'package:evently/ui/screens/my_events/my_events_screen.dart';
import 'package:evently/ui/widgets/event_screen_widget.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute loginRoute() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  static MaterialPageRoute signUpRoute() =>
      MaterialPageRoute(builder: (_) => const SignUpScreen());
  static MaterialPageRoute forgetPasswordRoute() =>
      MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
  static MaterialPageRoute mainRoute() =>
      MaterialPageRoute(builder: (_) => const MainScreen());
  static MaterialPageRoute addEventRoute() =>
      MaterialPageRoute(builder: (_) => const EventScreenWidget());
  static MaterialPageRoute eventDetailsRoute({
    required EventDm event,
    required String heroTag,
  }) => MaterialPageRoute(
    builder: (_) => EventDetailsScreen(event: event, heroTag: heroTag),
  );
  static MaterialPageRoute myEvents() =>
      MaterialPageRoute(builder: (_) => const MyEventsScreen());
  static MaterialPageRoute editEventRoute({required EventDm event}) =>
      MaterialPageRoute(builder: (_) => EventScreenWidget(event: event));
  static MaterialPageRoute editProfileRoute() =>
      MaterialPageRoute(builder: (_) => const EditProfileScreen());
  static MaterialPageRoute editPasswordRoute() =>
      MaterialPageRoute(builder: (_) => const EditPasswordScreen());
}
