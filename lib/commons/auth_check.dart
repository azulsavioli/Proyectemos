import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/registration/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  String? _userKey;
  Future<Widget>? _redirect;

  Future<Widget> _handleRedirect(User? currentUser) async {
    final preferences = await SharedPreferences.getInstance();

    if (currentUser == null) {
      return const LoginPage();
    }

    final bool isOnboardingDone = preferences.getBool('onboarding') ?? false;
    if (!isOnboardingDone) {
      return const OnboardingPage();
    }

    final bool isStudentInfoSaved =
        preferences.getBool('studentInfoSaved') ?? false;
    if (!isStudentInfoSaved) {
      return const RegistrationPage();
    }

    return const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          debugPrint('Erro no authStateChanges: ${snapshot.error}');
          return const LoginPage();
        }

        final user = snapshot.data;
        final key = user?.uid ?? '';
        if (_userKey != key || _redirect == null) {
          _userKey = key;
          _redirect = _handleRedirect(user);
        }

        return FutureBuilder<Widget>(
          future: _redirect,
          builder: (context, redirectSnapshot) {
            if (redirectSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (redirectSnapshot.hasError) {
              debugPrint('Erro ao redirecionar: ${redirectSnapshot.error}');
              return const LoginPage();
            }
            return redirectSnapshot.data ?? const LoginPage();
          },
        );
      },
    );
  }
}
