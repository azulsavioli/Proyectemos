// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider_artistas_impl.dart';
import 'package:proyectemos/providers/record_audio_provider_conoces_podcast_impl.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';
import 'package:proyectemos/providers/record_audio_provider_la_sociedad_impl.dart';
import 'package:proyectemos/repository/proyectemos_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/proyectemos_app.dart';
import 'commons/firebase_options.dart';
import 'providers/record_audio_provider_la_encuesta_tarea_dos.dart';
import 'providers/record_audio_provider_la_encuesta_tarea_uno.dart';
import 'providers/record_audio_provider_tu_alrededor_impl.dart';
import 'services/auth_services.dart';

bool? isOnboardingCompleted;
bool? isStudentInfoSaved;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final preferences = await SharedPreferences.getInstance();

  isOnboardingCompleted = preferences.getBool('onboarding');
  isStudentInfoSaved = preferences.getBool('studentInfoSaved');

  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.appAttest,
  // );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await ScreenUtil.ensureScreenSize();

  await initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(
            create: (_) => ProyectemosRepository(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioArtistasProviderImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioProviderEventoCulturalImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioConocesPodcastProviderImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioLaEncuestaTareaUnoProviderImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioLaEncuestaTareaDosProviderImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioLaSociedadProviderImpl(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecordAudioTuAlrededorProviderImpl(),
          ),
          ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
        ],
        child: Proyectemos(),
      ),
    ),
  );
}
