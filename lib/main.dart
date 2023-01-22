import 'package:flutter/material.dart';
import 'package:proyectemos/app/proyectemos_repository.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/proyectemos_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/services/auth_services.dart';
import 'commons/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

bool? isOnboardingCompleted;
bool? isStudentInfoSaved;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  isOnboardingCompleted = preferences.getBool('onboarding');
  isStudentInfoSaved = preferences.getBool('studentInfoSaved');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => ProyectemosRepository(
            authService: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ], child: const Proyectemos())));
}
