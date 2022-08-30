import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/proyectemos_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/services/auth_services.dart';
import 'commons/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

bool? isOnboardingCompleted;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  isOnboardingCompleted = preferences.getBool('onboarding');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ], child: const Proyectemos())));
}
