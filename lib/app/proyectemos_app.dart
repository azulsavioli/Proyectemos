import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/commons/auth_check.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import 'modules/proyecto_uno/artistas_latinoamericanos/record_and_play_audio.dart';
import 'modules/home/proyectos_page.dart';
import 'modules/login/recovery_page.dart';
import 'modules/proyecto_dos/proyecto_dos_page.dart';
import 'modules/proyecto_tres/proyecto_tres_page.dart';
import 'modules/proyecto_uno/artistas_latinoamericanos/tarea_dos.dart';
import 'modules/proyecto_uno/artistas_latinoamericanos/tarea_uno.dart';
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
              secondaryHeaderColor: ThemeColors.yellow),
          initialRoute: '/',
          routes: {
            '/': (context) => const AuthCheck(),
            '/home': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
            '/onboarding': (context) => const OnboardingPage(),
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
            '/proyecto_dos': (context) => const ProyectoDosPage(),
            '/proyecto_tres': (context) => const ProyectoTresPage(),
            '/record_and_play': (context) => const RecordAndPlayScreen(),
          },
        ),
      );
}
