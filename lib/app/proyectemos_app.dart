import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/criacao_evento_descricao.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/criacao_evento_feedback.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/evento_cultural_page.dart';
import 'package:proyectemos/commons/auth_check.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import 'modules/home/proyectos_page.dart';
import 'modules/login/recovery_page.dart';
import 'modules/login/registration_page.dart';
import 'modules/proyecto_dos/proyecto_dos_page.dart';
import 'modules/proyecto_tres/proyecto_tres_page.dart';
import 'modules/proyecto_uno/artistas_latinoamericanos/record_and_play_audio.dart';
import 'modules/proyecto_uno/artistas_latinoamericanos/tarea_dos.dart';
import 'modules/proyecto_uno/artistas_latinoamericanos/tarea_uno.dart';
import 'modules/proyecto_uno/divulgacion/divulgacao.dart';
import 'modules/proyecto_uno/evento_cultural/feedback_page.dart';
import 'modules/proyecto_uno/evento_cultural/record_and_play_audio_propuesta.dart';
import 'modules/proyecto_uno/latinoamerica/feed_latinoamerica.dart';
import 'modules/proyecto_uno/latinoamerica/tarea_dos.dart';
import 'modules/proyecto_uno/latinoamerica/tarea_tres.dart';
import 'modules/proyecto_uno/latinoamerica/tarea_uno.dart';
import 'modules/proyecto_uno/proyecto_uno_page.dart';

class Proyectemos extends StatelessWidget {
  const Proyectemos({Key? key}) : super(key: key);
  static const String title = '¡Proyectemos!';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primaryColor: ThemeColors.blue,
            secondaryHeaderColor: ThemeColors.yellow,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const AuthCheck(),
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/onboarding': (context) => const OnboardingPage(),
            '/registration': (context) => const RegistrationPage(),
            '/profile': (context) => const ProfilePage(),
            // '/tarefas_cumplidas': (context) => const TarefasCompletasPage(),
            // '/tarefas_pendientes': (context) => const TarefasIncompletasPage(),
            // '/agenda': (context) => const AgendaPage(),
            // '/tutorial': (context) => const TutorialPage(),
            '/recoveryPassword': (context) => const RecoveryPasswordPage(),
            '/proyectos': (context) => const ProyectosPage(),
            '/proyecto_uno': (context) => const ProyectoUnoPage(),
            '/pUno_latinoamerica_tarea_uno': (context) =>
                const PUnoLatinoamericaTareaUnoPage(),
            '/pUno_latinoamerica_tarea_dos': (context) =>
                const PUnoLatinoamericaTareaDosPage(),
            '/pUno_latinoamerica_tarea_tres': (context) =>
                const PUnoLatinoamericaTareaTresPage(),
            '/pUno_latinoamerica_feed': (context) =>
                const FeedLatinoamericaPage(),
            '/pUno_artistas_latinoamericanos_tarea_uno': (context) =>
                const PUnoArtistasLatinoamericanosTareaUnoPage(),
            '/pUno_artistas_latinoamericanos_tarea_dos': (context) =>
                const PUnoArtistasLatinoamericanosTareaDosPage(),
            '/pUno_evento_cultural': (context) => const EventoCulturalPage(),
            '/pUno_evento_cultural_descricao': (context) =>
                const CriacaoEventoDescricaoPage(),
            '/pUno_evento_cultural_feedback': (context) =>
                const CriacaoEventoFeedback(),
            '/pUno_divulgacao': (context) => const DivulgacaoPage(),
            '/pUno_feedback_page': (context) => const FeedbackPage(),
            '/proyecto_dos': (context) => const ProyectoDosPage(),
            '/proyecto_tres': (context) => const ProyectoTresPage(),
            '/record_and_play': (context) => const RecordAndPlayScreen(),
            '/record_and_play_propuesta': (context) =>
                const RecordAndPlayPropuestaScreen(),
          },
        ),
      );
}
