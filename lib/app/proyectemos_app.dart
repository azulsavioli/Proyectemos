import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/criacao_evento_page.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/evento_cultural_menu.dart';
import 'package:proyectemos/commons/auth_check.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import 'modules/home/proyectos_page.dart';
import 'modules/proyecto_dos/proyecto_dos_page.dart';
import 'modules/proyecto_tres/proyecto_tres_page.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/artistas_menu.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/feedback/feedback_tarea_dos.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/feedback/feedback_tarea_uno.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/record_and_play_audio.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/tareas/tarea_artistas_page.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/tareas/tarea_dos.dart';
import 'modules/proyecto_uno/divulgacion/divulgacao_tarea_page.dart';
import 'modules/proyecto_uno/divulgacion/feed_divulgation.dart';
import 'modules/proyecto_uno/divulgacion/feedback_tarea_divulgacion.dart';
import 'modules/proyecto_uno/evento_cultural/feedback_tarea_evento_cultural.dart';
import 'modules/proyecto_uno/evento_cultural/record_and_play_audio_propuesta.dart';
import 'modules/proyecto_uno/latinoamerica/feed_latinoamerica.dart';
import 'modules/proyecto_uno/latinoamerica/feedback/feedback_tarea_dos.dart';
import 'modules/proyecto_uno/latinoamerica/feedback/feedback_tarea_uno.dart';
import 'modules/proyecto_uno/latinoamerica/latinoamerica_menu.dart';
import 'modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_page.dart';
import 'modules/proyecto_uno/latinoamerica/tarea_uno/tarea_uno_page.dart';
import 'modules/proyecto_uno/proyecto_uno_page.dart';
import 'modules/registration/registration_page.dart';
import 'modules/teacher_contact/teacher_contact.dart';
import 'modules/widgets/enviar_email_professora.dart';

class Proyectemos extends StatelessWidget {
  const Proyectemos({Key? key}) : super(key: key);
  static const String title = '¡Proyectemos!';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Proyectemos.title,
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
                '/profile_contato_professora': (context) =>
                    const EnvioEmailProfesoraPerfil(),
                '/proyectos': (context) => const ProyectosPage(),
                '/proyecto_uno': (context) => const ProyectoUnoPage(),
                '/pUno_latinoamerica_menu': (context) =>
                    const PUnoLatinoamericaMenu(),
                '/pUno_latinoamerica_tarea_uno': (context) =>
                    const TareaUnoLatinoamericaPage(),
                '/pUno_latinoamerica_tarea_dos': (context) =>
                    const TareaDosLatinoamericaPage(),
                '/pUno_latinoamerica_feed': (context) =>
                    const FeedLatinoamericaPage(),
                '/pUno_latinoamerica_feedback_tarea_uno': (context) =>
                    const FeedbackTareaUnoLatinoamerica(),
                '/pUno_latinoamerica_feedback_tarea_dos': (context) =>
                    const FeedbackTareaDosLatinoamerica(),
                '/pUno_artistas_menu': (context) => const PUnoArtistasMenu(),
                '/pUno_artistas_frida': (context) =>
                    const TareaArtistasLatinoamericanosPage(),
                '/pUno_artistas_latinoamericanos_tarea_dos': (context) =>
                    const PUnoArtistasLatinoamericanosTareaDosPage(),
                '/pUno_artistas_feedback_tarea_uno': (context) =>
                    const FeedbackTareaUnoArtistas(),
                '/pUno_artistas_feedback_tarea_dos': (context) =>
                    const FeedbackTareaDosArtistas(),
                '/pUno_evento_cultural_menu': (context) =>
                    const EventoCulturalMenu(),
                '/pUno_criacao_evento_page': (context) =>
                    const CriacaoEventoPage(),
                '/pUno_evento_cultural_feedback': (context) =>
                    const FeedbackTareaEventoCultural(),
                '/pUno_divulgacao_page': (context) => const DivulgacaoPage(),
                '/pUno_divulgacao_feedback': (context) =>
                    const FeedbackTareaDivulgacion(),
                '/pUno_feed_divulgacao': (context) =>
                    const FeedDivulgationPage(),
                '/pUno_send_email_prof': (context) =>
                    const EnvioEmailProfesora(),
                '/proyecto_dos': (context) => const ProyectoDosPage(),
                '/proyecto_tres': (context) => const ProyectoTresPage(),
                '/record_and_play': (context) => const RecordAndPlayScreen(),
                '/record_and_play_propuesta': (context) =>
                    const RecordAndPlayPropuestaScreen(),
              },
            );
          },
        ),
      );
}
