import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commons/google_sign_in.dart';
import '../../services/auth_services.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(250, 251, 250, 1),
      child: Column(children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromRGBO(0, 159, 251, 1),
          ),
          child: Center(
            child: Text(
              '¡Proyectemos!',
              style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(250, 251, 250, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: const Text('Agenda'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.task_alt),
          title: const Text('Tareas Complidas'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.auto_stories_outlined),
          title: const Text('Tareas Inconclusas'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.tips_and_updates_outlined),
          title: const Text('Tutoriales'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Salir'),
          onTap: () {
            final auth = AuthService();
            auth.logout();
            Provider.of<GoogleSignnProvider>(context, listen: false);
          },
        )
      ]),
    );
  }
}
