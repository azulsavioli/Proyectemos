import 'package:flutter/material.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PDosCreacionEncuestaMenu extends StatefulWidget {
  const PDosCreacionEncuestaMenu({super.key});

  @override
  State<PDosCreacionEncuestaMenu> createState() =>
      _PDosCreacionEncuestaMenuState();
}

class _PDosCreacionEncuestaMenuState extends State<PDosCreacionEncuestaMenu> {
  bool tareaUno = false;
  bool isLoadingTarea = false;

  @override
  void initState() {
    super.initState();
    isTaskOneLoading();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await DosTasksCompletedService.getDosCreacionEncuestaCompletedInfo();

    setState(() {
      tareaUno = resultado;
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await UnoTasksCompletedService.isLoadind("creacionEncuestaCompleted");
    setState(() {
      isLoadingTarea = isTaskOneLoading;
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
            Strings.titleCreacionEncuesta,
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
                  iconSize: isMobile ? 25 : 45,
                  text: isLoadingTarea
                      ? 'Cargando\nCreacion de la encuesta'
                      : tareaUno
                          ? 'Feedback\nCreacion de la encuesta'
                          : 'Creacion de la encuesta',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pDos_creacionEncuesta_feedback'
                          : '/pDos_creacionEncuesta',
                  backgroundColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.yellow,
                  icon: isLoadingTarea
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.record_voice_over,
                  shadowColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
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
