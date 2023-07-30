import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/google_sign_in.dart';
import '../../../services/auth_services.dart';

class DrawerMenuWidget extends StatelessWidget {
  DrawerMenuWidget({Key? key}) : super(key: key);
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(250, 251, 250, 1),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 159, 251, 1),
              ),
              child: Center(
                child: Text(
                  '¡Proyectemos!',
                  style: ThemeText.paragraph16WhiteBold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Salir'),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              if (provider.googleSignIn.currentUser != null) {
                provider.googleLogout();
              } else {
                authService.logout();
              }
              Navigator.of(context).pushNamed('/login');
            },
          )
        ],
      ),
    );
  }
}
