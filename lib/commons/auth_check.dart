import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/registration/registration_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  Future<Widget> _handleRedirect(User? currentUser) async {
    final preferences = await SharedPreferences.getInstance();

    if (currentUser == null) {
      return const LoginPage();
    }

    final bool isOnboardingDone = preferences.getBool('onboarding') ?? false;
    if (!isOnboardingDone) {
      return const OnboardingPage();
    }

    final bool isStudentInfoSaved = preferences.getBool('studentInfoSaved') ?? false;
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
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          if (kDebugMode) print('Erro no authStateChanges: ${snapshot.error}');
          return const LoginPage();
        }

        final user = snapshot.data;

        return FutureBuilder<Widget>(
          future: _handleRedirect(user),
          builder: (context, redirectSnapshot) {
            if (redirectSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (redirectSnapshot.hasError) {
              if (kDebugMode) {
                print('Erro ao redirecionar: ${redirectSnapshot.error}');
              }
              return const LoginPage();
            }
            return redirectSnapshot.data ?? const LoginPage();
          },
        );
      },
    );
  }
}
