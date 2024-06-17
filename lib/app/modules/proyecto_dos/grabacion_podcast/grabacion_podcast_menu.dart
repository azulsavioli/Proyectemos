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
  bool isLoadingTareaUno = false;
  bool isLoadingTareaDos = false;
  bool timerEnded = false;

  @override
  void initState() {
    super.initState();
    isTaskOneLoading();
    isTaskDosLoading();
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

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading = await DosTasksCompletedService.isLoadind(
        "grabacionPodcastTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading = await DosTasksCompletedService.isLoadind(
        "grabacionPodcastTareaDosCompleted");
    setState(() {
      isLoadingTareaDos = isTaskTwoLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final widthTablet = MediaQuery.of(context).size.width * .95;
    final height = MediaQuery.of(context).size.width * .4;
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

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
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: isLoadingTareaUno
                      ? 'Cargando\nGuión de grabación'
                      : tareaUno
                          ? 'Feedback\nGuión de grabación'
                          : 'Guión de grabación',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pDos_grabacion_podcast_feedback_tarea_uno'
                          : '/pDos_grabacion_podcast_tarea_uno',
                  backgroundColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaUno
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.style,
                  shadowColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: isLoadingTareaDos
                      ? 'Cargando\nGrabar el podcast'
                      : tareaDos
                          ? 'Feedback\nGrabar el podcast'
                          : 'Grabar el podcast',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pDos_grabacion_podcast_feedback_tarea_dos'
                          : '/pDos_grabacion_podcast_tarea_dos',
                  backgroundColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaDos
                      ? Icons.hourglass_bottom_outlined
                      : tareaDos
                          ? Icons.check
                          : Icons.mic_external_on,
                  shadowColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (tareaUno && tareaDos && timerEnded)
                  CardButton(
                    iconSize: isMobile ? 30 : 50,
                    text: 'Feed de Podcasts',
                    cardWidth:  isMobile ? width : widthTablet,
                    cardHeight: height,
                    namedRoute: '/pDos_grabacion_podcast_feed',
                    backgroundColor: ThemeColors.green,
                    icon: Icons.podcasts,
                    shadowColor: ThemeColors.green,
                  )
                else if (tareaUno && tareaDos)
                  Card(
                    color: Colors.white,
                    elevation: 3,
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
