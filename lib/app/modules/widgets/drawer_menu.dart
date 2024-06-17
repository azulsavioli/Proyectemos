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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    return isMobile ? _drawerMenuMobile(context) : _drawerMenuTablet(context);
  }

  Widget _drawerMenuMobile(BuildContext context) {
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
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          SizedBox(
            height: 20,
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
          ),
        ],
      ),
    );
  }

  Widget _drawerMenuTablet(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(250, 251, 250, 1),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 159, 251, 1),
              ),
              child: Center(
                child: Text(
                  '¡Proyectemos!',
                  style: ThemeText.paragraph14WhiteBold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.home, size: 30,),
            title: Text('Inicio', style: ThemeText.paragraph12Gray),
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person, size: 30,),
            title: Text('Perfil', style: ThemeText.paragraph12Gray),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, size: 30,),
            title: Text('Salir', style: ThemeText.paragraph12Gray),
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
          ),
        ],
      ),
    );
  }
}
