import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/proyectemos_repository.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';
import 'package:proyectemos/providers/record_audio_provider_latinoamerica_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/proyectemos_app.dart';
import 'commons/firebase_options.dart';
import 'services/auth_services.dart';

bool? isOnboardingCompleted;
bool? isStudentInfoSaved;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  isOnboardingCompleted = preferences.getBool('onboarding');
  isStudentInfoSaved = preferences.getBool('studentInfoSaved');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidDebugProvider: true,
  // );

  await ScreenUtil.ensureScreenSize();

  await initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthService()),
          ChangeNotifierProvider(
            create: (context) => ProyectemosRepository(
              authService: context.read<AuthService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioProviderLatinoamericaImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioProviderEventoCulturalImpl(),
          ),
          ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
        ],
        child: const Proyectemos(),
      ),
    ),
  );
}
