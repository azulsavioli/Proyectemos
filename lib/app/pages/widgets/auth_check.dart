import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/pages/home_page.dart';
import 'package:proyectemos/app/pages/services/auth_services.dart';
import 'package:proyectemos/app/pages/widgets/login_page.dart';

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
      return const LoginPage(title: '¡Proyectemos!');
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(child: CircularProgressIndicator()));
  }
}
