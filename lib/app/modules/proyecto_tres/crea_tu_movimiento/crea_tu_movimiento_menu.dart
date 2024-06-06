import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../services/tres_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class CreacionDeSuMovimentoMenu extends StatefulWidget {
  const CreacionDeSuMovimentoMenu({super.key});

  @override
  State<CreacionDeSuMovimentoMenu> createState() =>
      _CreacionDeSuMovimentoMenuState();
}

class _CreacionDeSuMovimentoMenuState extends State<CreacionDeSuMovimentoMenu> {
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
    getTask();
  }

  Future<void> getTask() async {
    final resultado = await TresTasksCompletedService
        .getTresCreacionDeSuMovimentoCompletedInfo();

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
    final isTaskOneLoading = await TresTasksCompletedService.isLoadind(
        "creaTuMovimientoTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading = await TresTasksCompletedService.isLoadind(
        "creaTuMovimientoTareaDosCompleted");
    setState(() {
      isLoadingTareaDos = isTaskTwoLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .99;
    final height = MediaQuery.of(context).size.width * .4;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushNamed(context, '/proyecto_tres'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleCreaTuMovimiento,
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
                      ? 'Cargando\nNuestro movimiento social'
                      : tareaUno
                          ? 'Feedback\nNuestro movimiento social'
                          : 'Nuestro movimiento social',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pTres_feedback_creacionDeSuMovimento_tarea_uno'
                          : '/pTres_creacionDeSuMovimento_tarea_uno',
                  backgroundColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaUno
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.movie_filter_sharp,
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
                  iconSize: 30,
                  text: isLoadingTareaDos
                      ? 'Cargando\nLa red social del movimento'
                      : tareaDos
                          ? 'Feedback\nLa red social del movimento'
                          : 'La red social del movimento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pTres_feedback_creacionDeSuMovimento_tarea_dos'
                          : '/pTres_creacionDeSuMovimento_tarea_dos',
                  backgroundColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTareaDos
                      ? Icons.hourglass_bottom_outlined
                      : tareaDos
                          ? Icons.check
                          : Icons.accessibility_new_outlined,
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
                    iconSize: 30,
                    text: 'Feed de Podcasts',
                    cardWidth: width,
                    cardHeight: height,
                    namedRoute: '/pTres_feed_creacionDeSuMovimento_tarea_dos',
                    backgroundColor: ThemeColors.green,
                    icon: Icons.link,
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
