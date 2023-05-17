import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/strings.dart';
import '../../../../services/tasks_completed.dart';
import '../../../../services/toast_services.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PUnoLatinoamericaMenu extends StatefulWidget {
  const PUnoLatinoamericaMenu({super.key});

  @override
  State<PUnoLatinoamericaMenu> createState() => _PUnoLatinoamericaMenuState();
}

class _PUnoLatinoamericaMenuState extends State<PUnoLatinoamericaMenu> {
  bool tareaUno = false;
  bool tareaDos = false;
  bool tareaTres = false;
  bool timerEnded = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await TasksCompletedService.getUnoLatinoamericaTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
      tareaTres = resultado[2];
    });

    if (tareaUno && tareaDos && tareaTres) {
      await Future.delayed(
        const Duration(seconds: 5),
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
            onPressed: () => Navigator.pushNamed(context, '/proyecto_uno'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleLatinoamericaUno,
            style: ThemeText.paragraph16WhiteBold,
          ),
        ),
        endDrawer: const DrawerMenuWidget(),
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
                  text: 'Descubre la musica',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pUno_latinoamerica_feedback_tarea_uno'
                      : '/pUno_latinoamerica_tarea_uno',
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
                  text: 'Describe la musica',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaDos
                      ? '/pUno_latinoamerica_feedback_tarea_dos'
                      : '/pUno_latinoamerica_tarea_dos',
                  backgroundColor:
                      tareaDos ? ThemeColors.green : ThemeColors.red,
                  icon: tareaDos ? Icons.check : Icons.edit,
                  shadowColor: tareaDos ? ThemeColors.green : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: 'Selección de imágenes\nLatinoamérica',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaTres
                      ? '/pUno_latinoamerica_feedback_tarea_tres'
                      : '/pUno_latinoamerica_tarea_tres',
                  backgroundColor:
                      tareaTres ? ThemeColors.green : ThemeColors.red,
                  icon: tareaTres ? Icons.check : Icons.image,
                  shadowColor: tareaTres ? ThemeColors.green : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (tareaUno && tareaDos && tareaTres && timerEnded)
                  CardButton(
                    iconSize: 30,
                    text: 'Feed de imágenes\nLatinoamérica',
                    cardWidth: width,
                    cardHeight: height,
                    namedRoute: '/pUno_latinoamerica_feed',
                    backgroundColor: ThemeColors.red,
                    icon: Icons.image,
                    shadowColor: ThemeColors.red,
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ThemeColors.red),
          ),
          onPressed: restoreTasks,
          icon: const Icon(Icons.restore),
          label: const Text('Reset'),
        ),
      ),
    );
  }

  void restoreTasks() {
    TasksCompletedService.restoreAllTasks();
    getTaskCompleted();
    showToast('Tareas resetadas con successo!');
  }
}