import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/login/registration_page.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/main.dart';

import '../app/modules/onboarding/onboarding_page.dart';
import '../utils/get_user.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    if (currentUser == null) {
      return const LoginPage();
    } else {
      return isOnboardingCompleted == null
          ? const OnboardingPage()
          : isStudentInfoSaved == null
              ? const RegistrationPage()
              : const HomePage();
    }
  }
}
