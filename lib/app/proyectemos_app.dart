import 'package:flutter/material.dart';
import 'package:proyectemos/app/pages/widgets/auth_check.dart';

class Proyectemos extends StatelessWidget {
  const Proyectemos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡Proyectemos!',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const AuthCheck(),
    );
  }
}
