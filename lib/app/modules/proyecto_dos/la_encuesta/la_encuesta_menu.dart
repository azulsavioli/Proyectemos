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

  @override
  void initState() {
    super.initState();
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
                  text: tareaUno
                      ? StringsLaEncuesta.titleFeedbackTareaUnoQueEsUnaEncuesta
                      : StringsLaEncuesta.titleTareaUnoQueEsUnaEncuesta,
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pDos_que_es_una_encuesta_feedback_tarea_uno'
                      : '/pDos_que_es_una_encuesta_tarea_uno',
                  backgroundColor:
                      tareaUno ? ThemeColors.green : ThemeColors.red,
                  icon: tareaUno ? Icons.check : Icons.music_note_sharp,
                  shadowColor: tareaUno ? ThemeColors.green : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: tareaDos
                      ? StringsLaEncuesta
                          .titleFeedbackTareaDosComoCrearUnaEncuesta
                      : StringsLaEncuesta.titleTareaDosComoCrearUnaEncuesta,
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaDos
                      ? '/pDos_crear_una_encuesta_feedback_tarea_dos'
                      : '/pDos_crear_una_encuesta_tarea_dos',
                  backgroundColor:
                      tareaDos ? ThemeColors.green : ThemeColors.red,
                  icon: tareaDos ? Icons.check : Icons.image,
                  shadowColor: tareaDos ? ThemeColors.green : ThemeColors.red,
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
