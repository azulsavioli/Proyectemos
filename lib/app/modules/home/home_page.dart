import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';

import '../widgets/drawer_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          '¡Proyectemos!',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const DrawerMenuWidget(),
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
    ));
  }
}
