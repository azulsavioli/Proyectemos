import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/login/registration_page.dart';
import 'package:proyectemos/main.dart';

import '../app/modules/onboarding/onboarding_page.dart';
import 'google_sign_in.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final currentUser = provider.auth.currentUser;

    try {
      if (currentUser == null) {
        return const LoginPage();
      } else {
        return isOnboardingCompleted == null
            ? const OnboardingPage()
            : isStudentInfoSaved == null
                ? const RegistrationPage()
                : const HomePage();
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
