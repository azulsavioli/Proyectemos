import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PDosComoCrearPodcastMenu extends StatefulWidget {
  const PDosComoCrearPodcastMenu({super.key});

  @override
  State<PDosComoCrearPodcastMenu> createState() =>
      _PDosComoCrearPodcastMenuState();
}

class _PDosComoCrearPodcastMenuState extends State<PDosComoCrearPodcastMenu> {
  bool tareaUno = false;
  bool tareaDos = false;
  bool isLoadingTareaUno = false;
  bool isLoadingTareaDos = false;

  @override
  void initState() {
    super.initState();
    isTaskOneLoading();
    isTaskDosLoading();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado = await DosTasksCompletedService
        .getDosComoCrearPodcastTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading = await DosTasksCompletedService.isLoadind(
        "comoCrearPodcastTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading = await DosTasksCompletedService.isLoadind(
        "comoCrearPodcastTareaDosCompleted");
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
            Strings.titleComoCrearPodcast,
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
                      ? 'Cargando\nEl contenido del podcast'
                      : tareaUno
                          ? 'Feedback\nEl contenido del podcast'
                          : 'El contenido del podcast',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pDos_escuchar_podcast_feedback_tarea_uno'
                          : '/pDos_escuchar_podcast_tarea_uno',
                  backgroundColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaUno
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.music_note_sharp,
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
                      ? 'Cargando\nCrear un Podcast'
                      : tareaDos
                          ? 'Feedback\nCrear un Podcast'
                          : 'Crear un Podcast',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pDos_crear_un_podcast_feedback_tarea_dos'
                          : '/pDos_crear_un_podcast_tarea_dos',
                  backgroundColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaDos
                      ? Icons.hourglass_bottom_outlined
                      : tareaDos
                          ? Icons.check
                          : Icons.image,
                  shadowColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.yellow,
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
