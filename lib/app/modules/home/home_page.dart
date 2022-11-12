import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/home/proyectos_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const ProyectosPage();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Algo deu errado!'));
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
