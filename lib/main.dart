import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/auth_service.dart';
import 'package:evently/services/shared_prefs_service.dart';
import 'package:evently/ui/screens/auth/login/login_screen.dart';
import 'package:evently/ui/screens/main/main_screen.dart';
import 'package:evently/ui/screens/onboarding/onboarding_screen.dart';
import 'package:evently/ui/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AuthService().initGoogleSignIn();
  await SharedPrefsService.init();

  UserDm? currentUserDm;
  final currentUser = AuthService().currentUser;

  if (!SharedPrefsService.isFirstTime && currentUser != null) {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        currentUserDm = UserDm.fromJson(userDoc.data()!);
      }
    } catch (e) {
      debugPrint("Error fetching user session: $e");
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = UserProvider();
            if (currentUserDm != null) {
              provider.setUser(currentUserDm);
            }
            return provider;
          },
        ),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(hasSession: currentUserDm != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSession;
  const MyApp({super.key, required this.hasSession});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evently',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.locale),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: getInitialScreen(),
    );
  }

  Widget getInitialScreen() {
    if (SharedPrefsService.isFirstTime) {
      return const OnboardingScreen();
    } else if (hasSession) {
      return const MainScreen();
    } else {
      return const LoginScreen();
    }
  }
}
