import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/pages/widgets/auth_check.dart';
import 'package:proyectemos/google_sign_in.dart';

class Proyectemos extends StatelessWidget {
  const Proyectemos({Key? key}) : super(key: key);
  static const String title = '¡Proyectemos!';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignnProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const AuthCheck(),
      ));
}
