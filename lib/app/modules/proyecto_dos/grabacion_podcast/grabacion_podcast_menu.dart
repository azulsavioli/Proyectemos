import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PDosGrabacionPodcastMenu extends StatefulWidget {
  const PDosGrabacionPodcastMenu({super.key});

  @override
  State<PDosGrabacionPodcastMenu> createState() =>
      _PDosGrabacionPodcastMenuState();
}

class _PDosGrabacionPodcastMenuState extends State<PDosGrabacionPodcastMenu> {
  bool tareaUno = false;
  bool tareaDos = false;
  bool timerEnded = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await DosTasksCompletedService.getDosGrabacionPodcastCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
    });

    if (tareaUno && tareaDos) {
      await Future.delayed(
        const Duration(seconds: 3),
        () => setState(
          () => timerEnded = true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.width * .4;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
            onPressed: () => Navigator.pushNamed(context, '/proyecto_dos'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleGrabacionPodcast,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
        endDrawer: DrawerMenuWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: tareaUno
                      ? 'Feedback\nGuión de grabación'
                      : 'Guión de grabación',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pDos_grabacion_podcast_feedback_tarea_uno'
                      : '/pDos_grabacion_podcast_tarea_uno',
                  backgroundColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
                  icon: tareaUno ? Icons.check : Icons.style,
                  shadowColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: tareaDos
                      ? 'Feedback\nGrabar el podcast'
                      : 'Grabar el podcast',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaDos
                      ? '/pDos_grabacion_podcast_feedback_tarea_dos'
                      : '/pDos_grabacion_podcast_tarea_dos',
                  backgroundColor:
                      tareaDos ? ThemeColors.green : ThemeColors.yellow,
                  icon: tareaDos ? Icons.check : Icons.mic_external_on,
                  shadowColor:
                      tareaDos ? ThemeColors.green : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (tareaUno && tareaDos && timerEnded)
                  CardButton(
                    iconSize: 30,
                    text: 'Feed de Podcasts',
                    cardWidth: width,
                    cardHeight: height,
                    namedRoute: '/pDos_grabacion_podcast_feed',
                    backgroundColor: ThemeColors.green,
                    icon: Icons.image,
                    shadowColor: ThemeColors.green,
                  )
                else if (tareaUno && tareaDos)
                  Card(
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.blue,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
