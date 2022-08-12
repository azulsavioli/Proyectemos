import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/pages/services/auth_services.dart';
import 'package:proyectemos/app/pages/widgets/proyectos_page.dart';
import 'package:proyectemos/app/pages/widgets/login_page.dart';
import 'package:proyectemos/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '¡Proyectemos!',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final auth = AuthService();
                auth.logout();
                final provider =
                    Provider.of<GoogleSignnProvider>(context, listen: false);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ]),
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
              return const LoginPage(
                title: '¡Proyectemos!',
              );
            }
          }),
    );
  }
}
