import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/onboarding/onboarding_page.dart';
import 'package:proyectemos/app/modules/profile/profile_page.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/tarea_uno_como_crear_podcast.dart';
import 'package:proyectemos/app/modules/proyecto_dos/creacion_encuesta/creacion_encuesta_feedback.dart';
import 'package:proyectemos/app/modules/proyecto_uno/evento_cultural/evento_cultural_menu.dart';
import 'package:proyectemos/commons/auth_check.dart';

import '../app/modules/home/proyectos_page.dart';
import '../app/modules/proyecto_dos/como_crear_podcast/como_crear_podcast_menu.dart';
import '../app/modules/proyecto_dos/como_crear_podcast/tarea_dos/feedback_tarea_dos_conoces_podcast.dart';
import '../app/modules/proyecto_dos/como_crear_podcast/tarea_dos/tarea_dos_como_crear_podcast.dart';
import '../app/modules/proyecto_dos/como_crear_podcast/tarea_uno/feedback_tarea_uno_conoces_podcast.dart';
import '../app/modules/proyecto_dos/creacion_encuesta/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_dos/el_podcast/feedback_tarea_conoces_podcast.dart';
import '../app/modules/proyecto_dos/el_podcast/tarea_uno/record_and_play_audio_conoces_podcast.dart';
import '../app/modules/proyecto_dos/el_podcast/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/feed_grabacion_podcast.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/grabacion_podcast_menu.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/tarea_dos/feedback_tarea_dos_grabacion_podcast.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/tarea_dos/tarea_dos_page.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/tarea_uno/feedback_tarea_uno_grabacion_podcast.dart';
import '../app/modules/proyecto_dos/grabacion_podcast/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_dos/la_encuesta/la_encuesta_menu.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_dos/feedback_tarea_como_crear_una_encuesta.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_dos/record_and_play_audio_la_encuesta.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_dos/tarea_dos_page.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_uno/feedback_tarea_que_es_escuesta.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_uno/record_and_play_audio_la_encuesta.dart';
import '../app/modules/proyecto_dos/la_encuesta/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_dos/proyecto_dos_page.dart';
import '../app/modules/proyecto_tres/proyecto_tres_page.dart';
import '../app/modules/proyecto_uno/artistas_hispanoamericanos/artistas_menu.dart';
import '../app/modules/proyecto_uno/artistas_hispanoamericanos/feedback/feedback_tarea_dos.dart';
import '../app/modules/proyecto_uno/artistas_hispanoamericanos/feedback/feedback_tarea_uno.dart';
import 'modules/proyecto_tres/tu_alrededor/record_and_play_audio_tu_alrededor.dart';
import 'modules/proyecto_uno/artistas_hispanoamericanos/tarea_uno/record_and_play_audio.dart';
import '../app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/tarea_dos_page.dart';
import '../app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_uno/divulgacion/feed_divulgation.dart';
import '../app/modules/proyecto_uno/divulgacion/feedback_tarea_divulgacion.dart';
import '../app/modules/proyecto_uno/divulgacion/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_uno/evento_cultural/feedback_tarea_evento_cultural.dart';
import '../app/modules/proyecto_uno/evento_cultural/record_and_play_audio_propuesta.dart';
import '../app/modules/proyecto_uno/evento_cultural/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_uno/latinoamerica/feed_latinoamerica.dart';
import '../app/modules/proyecto_uno/latinoamerica/feedback/feedback_tarea_dos.dart';
import '../app/modules/proyecto_uno/latinoamerica/feedback/feedback_tarea_uno.dart';
import '../app/modules/proyecto_uno/latinoamerica/latinoamerica_menu.dart';
import '../app/modules/proyecto_uno/latinoamerica/tarea_dos/tarea_dos_page.dart';
import '../app/modules/proyecto_uno/latinoamerica/tarea_uno/tarea_uno_page.dart';
import '../app/modules/proyecto_uno/proyecto_uno_page.dart';
import '../app/modules/registration/registration_page.dart';
import '../app/modules/teacher_contact/teacher_contact.dart';
import '../app/modules/widgets/enviar_email_professora.dart';
import 'modules/proyecto_tres/crea_tu_movimiento/crea_tu_movimiento_menu.dart';
import 'modules/proyecto_tres/crea_tu_movimiento/tarea_dos/creacion_e_tu_movimiento_tarea_dos.dart';
import 'modules/proyecto_tres/crea_tu_movimiento/tarea_uno/creacion_de_su_movimiento_tarea_uno.dart';
import 'modules/proyecto_tres/la_sociedad/feedback_tarea_uno.dart';
import 'modules/proyecto_tres/la_sociedad/la_sociedade.dart';
import 'modules/proyecto_tres/la_sociedad/record_and_play_audio_la_sociedad.dart';
import 'modules/proyecto_tres/las_redes_sociales_y_el_activismo/las_redes_sociales_y_el_activismo.dart';
import 'modules/proyecto_tres/movimientos_sociales/movimientos_sociales_menu.dart';
import 'modules/proyecto_tres/movimientos_sociales/tarea_dos/movimientos_sociales_tarea_dos.dart';
import 'modules/proyecto_tres/movimientos_sociales/tarea_uno/movimientos_sociales_tarea_unio.dart';
import 'modules/proyecto_tres/tu_alrededor/tu_alrededor.dart';

final routes = {
  '/': (context) => const AuthCheck(),
  '/login': (context) => const LoginPage(),
  '/home': (context) => const HomePage(),
  '/onboarding': (context) => const OnboardingPage(),
  '/registration': (context) => const RegistrationPage(),
  '/profile': (context) => const ProfilePage(),
  '/profile_contato_professora': (context) => const EnvioEmailProfesoraPerfil(),
  '/proyectos': (context) => const ProyectosPage(),
  '/record_and_play': (context) => const RecordAndPlayScreen(),

//projeto uno

  '/proyecto_uno': (context) => const ProyectoUnoPage(),
  '/pUno_latinoamerica_menu': (context) => const PUnoLatinoamericaMenu(),
  '/pUno_latinoamerica_tarea_uno': (context) =>
      const TareaUnoLatinoamericaPage(),
  '/pUno_latinoamerica_tarea_dos': (context) =>
      const PUnoLatinoamericaTareaDosPage(),
  '/pUno_latinoamerica_feed': (context) => const FeedLatinoamericaPage(),
  '/pUno_latinoamerica_feedback_tarea_uno': (context) =>
      const FeedbackTareaUnoLatinoamerica(),
  '/pUno_latinoamerica_feedback_tarea_dos': (context) =>
      const FeedbackTareaDosLatinoamerica(),
  '/pUno_artistas_menu': (context) => const PUnoArtistasMenu(),
  '/pUno_artistas_frida': (context) =>
      const TareaArtistasLatinoamericanosPage(),
  '/pUno_artistas_tarea_dos': (context) =>
      const PUnoArtistasLatinoamericanosTareaDosPage(),
  '/pUno_artistas_feedback_tarea_uno': (context) =>
      const FeedbackTareaUnoArtistas(),
  '/pUno_artistas_feedback_tarea_dos': (context) =>
      const FeedbackTareaDosArtistas(),
  '/pUno_evento_cultural_menu': (context) => const EventoCulturalMenu(),
  '/pUno_criacao_evento_page': (context) => const PUnoEventoCulturalTareaPage(),
  '/pUno_evento_cultural_feedback': (context) =>
      const FeedbackTareaEventoCultural(),
  '/record_and_play_propuesta': (context) =>
      const RecordAndPlayPropuestaScreen(),
  '/pUno_divulgacao_page': (context) => const TareaDivulgacaoPage(),
  '/pUno_divulgacao_feedback': (context) => const FeedbackTareaDivulgacion(),
  '/pUno_feed_divulgacao': (context) => const FeedDivulgationPage(),
  '/pUno_send_email_prof': (context) => const EnvioEmailProfesora(),

//projeto dos

  '/proyecto_dos': (context) => const ProyectoDosPage(),
  '/pDos_conocesPodcast': (context) => const PDosConocesPodcast(),
  '/pDos_conocesPodcast_feedback': (context) =>
      const FeedbackTareaConocesPodcast(),
  '/record_and_play_conoces_podcast': (context) =>
      const RecordAndPlayConocesPodcastScreen(),
  '/pDos_comoCrearPodcast_menu': (context) => const PDosComoCrearPodcastMenu(),
  '/pDos_escuchar_podcast_tarea_uno': (context) =>
      const TareaUnoEscucharPodcast(),
  '/pDos_escuchar_podcast_feedback_tarea_uno': (context) =>
      const FeedbackTareaUnoComoCrearPodcast(),
  '/pDos_crear_un_podcast_tarea_dos': (context) =>
      const TareaDosCrearUnPodcast(),
  '/pDos_crear_un_podcast_feedback_tarea_dos': (context) =>
      const FeedbackTareaDosComoCrearPodcast(),
  '/pDos_laEncuesta_menu': (context) => const PDosLaEncuestaMenu(),
  '/pDos_que_es_una_encuesta_tarea_uno': (context) =>
      const TareaUnoQueEsUnaEncuesta(),
  '/pDos_que_es_una_encuesta_feedback_tarea_uno': (context) =>
      const FeedbackTareaUnoLaEncuesta(),
  '/record_and_play_la_encuesta_tarea_uno': (context) =>
      const RecordAndPlayLaEncuestaTareaUnoScreen(),
  '/pDos_crear_una_encuesta_tarea_dos': (context) =>
      const TareaDosComoCrearUnaEncuestaPage(),
  '/pDos_crear_una_encuesta_feedback_tarea_dos': (context) =>
      const FeedbackTareaDosLaEncuesta(),
  '/record_and_play_la_encuesta_tarea_dos': (context) =>
      const RecordAndPlayLaEncuestaTareaDosScreen(),
  '/pDos_creacionEncuesta': (context) => const PDosCreacionEncuesta(),
  '/pDos_creacionEncuesta_feedback': (context) =>
      const FeedbackTareaCreacionEncuesta(),
  '/pDos_grabacionPodcast_menu': (context) => const PDosGrabacionPodcastMenu(),
  '/pDos_grabacion_podcast_tarea_uno': (context) =>
      const TareaUnoGrabacionPodcast(),
  '/pDos_grabacion_podcast_feedback_tarea_uno': (context) =>
      const FeedbackTareaUnoGrabacionPodcast(),
  '/pDos_grabacion_podcast_tarea_dos': (context) =>
      const TareaDosGrabacionPodcastPage(),
  '/pDos_grabacion_podcast_feedback_tarea_dos': (context) =>
      const FeedbackTareaDosGrabacionPodcast(),
  '/pDos_grabacion_podcast_feed': (context) => const FeedGrabacionPodcastPage(),

//projeto tres
  '/proyecto_tres': (context) => const ProyectoTresPage(),
  '/pTres_laSociedad': (context) => const LaSociedadPage(),
  '/pTres_laSociedad_feedback_tarea_uno': (context) =>
      const FeedbackTareaLaSociedad(),
  '/record_and_play_la_sociedad': (context) => const RecordAndPlayLaSociedad(),
  '/pTres_movimientosSociales_menu': (context) =>
      const MovimientosSocialesMenu(),
  '/pTres_movimientosSociales_tarea_uno': (context) =>
      const MovimientosSocialesTareaUno(),
  '/pTres_movimientosSociales_tarea_dos': (context) =>
      const MovimientosSocialesTareaDos(),
  '/pTres_tuAlrededor': (context) => const TuAlrededor(),
  '/record_and_play_tu_alrededor': (context) =>
      const RecordAndPlayTuAlrededor(),
  '/pTres_lasRedesSocialesYElActivismo': (context) =>
      const LasRedesSocialesYElActivismo(),
  '/pTres_creacionDeSuMovimentoCompleted_menu': (context) =>
      const CreacionDeSuMovimentoMenu(),
  '/pTres_creacionDeSuMovimentoCompleted_tarea_uno': (context) =>
      const CreacionDeSuMovimentoTareaUno(),
  '/pTres_creacionDeSuMovimentoCompleted_tarea_dos': (context) =>
      const CreacionDeSuMovimentoTareaDos(),
};

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
                platform: TargetPlatform.iOS,
                scaffoldBackgroundColor: ThemeColors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: ThemeColors.blue,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: ThemeColors.white),
                ),
              ),
              home: const AuthCheck(),
              initialRoute: '/',
              routes: Map.from(routes)..remove(Navigator.defaultRouteName),
            );
          },
        ),
      );
}
