import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'providers/acessibility_provider.dart';
import 'providers/record_audio_provider_la_encuesta_tarea_dos.dart';
import 'providers/record_audio_provider_la_encuesta_tarea_uno.dart';
import 'providers/record_audio_provider_tu_alrededor_impl.dart';
import 'services/auth_services.dart';

bool? isOnboardingCompleted;
bool? isStudentInfoSaved;

/// Web client (client_type 3) from android/app/google-services.json.
/// Used when .env does not override SERVER_CLIENT_ID.
const _defaultServerClientId =
    '333978861746-p88q9nentd8ogn0q30e9qv24rjlouno5.apps.googleusercontent.com';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadOptionalEnv();

  await GoogleSignIn.instance.initialize(
    clientId: _envOrNull('CLIENT_ID'),
    serverClientId: _envOrNull('SERVER_CLIENT_ID') ?? _defaultServerClientId,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final preferences = await SharedPreferences.getInstance();

  isOnboardingCompleted = preferences.getBool('onboarding');
  isStudentInfoSaved = preferences.getBool('studentInfoSaved');

  try {
    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      providerAndroid: kDebugMode
          ? const AndroidDebugProvider()
          : const AndroidPlayIntegrityProvider(),
    );
  } catch (e) {
    debugPrint('Firebase App Check não ativado: $e');
  }

  await ScreenUtil.ensureScreenSize();

  await initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
          ChangeNotifierProvider(create: (_) => ProyectemosRepository()),
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

Future<void> _loadOptionalEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Arquivo .env opcional não carregado: $e');
  }
}

String? _envOrNull(String key) {
  try {
    final value = dotenv.env[key];
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  } catch (_) {
    return null;
  }
}
