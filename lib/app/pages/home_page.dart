import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/pages/services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            onPressed: () => context.read<AuthService>().logout(),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ]));
  }
}
