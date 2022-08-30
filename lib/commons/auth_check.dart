import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/main.dart';

import '../app/modules/onboarding/onboarding_page.dart';
import '../app/services/auth_services.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.userAuth == null) {
      return const LoginPage();
    } else {
      return isOnboardingCompleted == true
          ? const HomePage()
          : const OnboardingPage();
    }
  }

  loading() {
    return const Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(child: CircularProgressIndicator()));
  }
}
