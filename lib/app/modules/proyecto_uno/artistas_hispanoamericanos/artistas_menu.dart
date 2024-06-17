import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PUnoArtistasMenu extends StatefulWidget {
  const PUnoArtistasMenu({super.key});

  @override
  State<PUnoArtistasMenu> createState() => _PUnoArtistasMenuState();
}

class _PUnoArtistasMenuState extends State<PUnoArtistasMenu> {
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
        await UnoTasksCompletedService.getUnoArtistasTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await UnoTasksCompletedService.isLoadind("artistasTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading =
        await UnoTasksCompletedService.isLoadind("artistasTareaDosCompleted");
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
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, size: isMobile ? 20 : 50),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          toolbarHeight: isMobile ? 60 : 110,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: ThemeColors.white, size: isMobile ? 20 : 50),
              onPressed: () => Navigator.pushNamed(context, '/proyecto_uno'),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleArtistasHispanoamericanos,
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
                      ? 'Cargando Frida Kahlo'
                      : tareaUno
                          ? 'Feedback Frida Kahlo'
                          : 'Frida Kahlo',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pUno_artistas_feedback_tarea_uno'
                          : '/pUno_artistas_frida',
                  backgroundColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.blue,
                  icon: isLoadingTareaUno
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.record_voice_over,
                  shadowColor: isLoadingTareaUno
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: isLoadingTareaDos
                      ? 'Cargando\nSelección de archivos'
                      : tareaDos
                          ? 'Feedback\nSelección de archivos'
                          : 'Selección de archivos',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pUno_artistas_feedback_tarea_dos'
                          : '/pUno_artistas_tarea_dos',
                  backgroundColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.blue,
                  icon: isLoadingTareaDos
                      ? Icons.hourglass_bottom_outlined
                      : tareaDos
                          ? Icons.check
                          : Icons.file_copy,
                  shadowColor: isLoadingTareaDos
                      ? ThemeColors.grayLight
                      : tareaDos
                          ? ThemeColors.green
                          : ThemeColors.blue,
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
