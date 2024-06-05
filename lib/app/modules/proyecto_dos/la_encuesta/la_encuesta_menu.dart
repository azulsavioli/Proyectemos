import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/strings/strings_la_encuesta.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PDosLaEncuestaMenu extends StatefulWidget {
  const PDosLaEncuestaMenu({super.key});

  @override
  State<PDosLaEncuestaMenu> createState() => _PDosLaEncuestaMenuState();
}

class _PDosLaEncuestaMenuState extends State<PDosLaEncuestaMenu> {
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
    final resultado =
        await DosTasksCompletedService.getDosLaEncuestaTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await DosTasksCompletedService.isLoadind("laEncuestaTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading =
        await DosTasksCompletedService.isLoadind("laEncuestaTareaDosCompleted");
    setState(() {
      isLoadingTareaDos = isTaskTwoLoading;
    });
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
            Strings.titleLaEncuesta,
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
                  text: isLoadingTareaUno
                      ? StringsLaEncuesta.titleTareaUnoQueEsUnaEncuestaLoading
                      : tareaUno
                          ? StringsLaEncuesta
                              .titleFeedbackTareaUnoQueEsUnaEncuesta
                          : StringsLaEncuesta.titleTareaUnoQueEsUnaEncuesta,
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pDos_que_es_una_encuesta_feedback_tarea_uno'
                          : '/pDos_que_es_una_encuesta_tarea_uno',
                  backgroundColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.red,
                  icon: isLoadingTareaUno
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.music_note_sharp,
                  shadowColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: isLoadingTareaDos
                      ? StringsLaEncuesta
                          .titleTareaDosComoCrearUnaEncuestaLoading
                      : tareaDos
                          ? StringsLaEncuesta
                              .titleFeedbackTareaDosComoCrearUnaEncuesta
                          : StringsLaEncuesta.titleTareaDosComoCrearUnaEncuesta,
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pDos_crear_una_encuesta_feedback_tarea_dos'
                          : '/pDos_crear_una_encuesta_tarea_dos',
                  backgroundColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.red,
                  icon: isLoadingTareaDos
                      ? Icons.hourglass_bottom_outlined
                      : tareaDos
                          ? Icons.check
                          : Icons.image,
                  shadowColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.red,
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
