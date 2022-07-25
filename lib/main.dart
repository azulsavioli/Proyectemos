import 'package:flutter/material.dart';
import 'package:proyectemos/app/pages/services/auth_services.dart';
import 'app/proyectemos_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: const Proyectemos(),
  ));
}
