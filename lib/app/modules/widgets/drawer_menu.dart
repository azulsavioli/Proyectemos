import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/google_sign_in.dart';
import '../../services/auth_services.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(250, 251, 250, 1),
      child: Column(children: [
        const SizedBox(
          height: 90,
          child: DrawerHeader(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromRGBO(0, 159, 251, 1),
            ),
            child: Center(
              child: Text(
                '¡Proyectemos!',
                style: ThemeText.title20White,
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
          leading: const Icon(Icons.calendar_month_outlined),
          title: const Text('Agenda'),
          onTap: () {
            Navigator.of(context).pushNamed('/agenda');
          },
        ),
        ListTile(
          leading: const Icon(Icons.task_alt),
          title: const Text('Tareas Cumplidas'),
          onTap: () {
            Navigator.of(context).pushNamed('/tarefas_cumplidas');
          },
        ),
        ListTile(
          leading: const Icon(Icons.auto_stories_outlined),
          title: const Text('Tareas Pendientes'),
          onTap: () {
            Navigator.of(context).pushNamed('/tarefas_pendientes');
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
          leading: const Icon(Icons.tips_and_updates_outlined),
          title: const Text('Tutoriales'),
          onTap: () {
            Navigator.of(context).pushNamed('/tutorial');
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Salir'),
          onTap: () {
            final auth = AuthService();
            auth.logout();
            Provider.of<GoogleSignInProvider>(context, listen: false);
          },
        )
      ]),
    );
  }
}
