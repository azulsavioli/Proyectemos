import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../services/uno_tasks_completed.dart';
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
  bool timerEnded = false;
  bool isLoadingTareaUno = false;
  bool isLoadingTareaDos = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isTaskOneLoading();
      isTaskDosLoading();
      getTaskCompleted();
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading = await UnoTasksCompletedService.isLoadind(
        "latinoamericaTareaUnoCompleted");
    setState(() {
      isLoadingTareaUno = isTaskOneLoading;
    });
  }

  Future<void> isTaskDosLoading() async {
    final isTaskTwoLoading = await UnoTasksCompletedService.isLoadind(
        "latinoamericaTareaDosCompleted");
    setState(() {
      isLoadingTareaDos = isTaskTwoLoading;
    });
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await UnoTasksCompletedService.getUnoLatinoamericaTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
    });

    if (tareaUno && tareaDos) {
      await Future.delayed(
        const Duration(seconds: 3),
        () => setState(() => timerEnded = true),
      );
    }
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
            Strings.titleLatinoamericaUno,
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
                const SizedBox(height: 20),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: isLoadingTareaUno
                      ? 'Cargando 300 kilos'
                      : tareaUno
                          ? 'Feedback 300 kilos'
                          : '300 kilos',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaUno
                      ? null
                      : tareaUno
                          ? '/pUno_latinoamerica_feedback_tarea_uno'
                          : '/pUno_latinoamerica_tarea_uno',
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
                const SizedBox(height: 20),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: isLoadingTareaDos
                      ? 'Cargando\nTu Latinoamérica'
                      : tareaDos
                          ? 'Feedback\nTu Latinoamérica'
                          : 'Tu Latinoamérica',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTareaDos
                      ? null
                      : tareaDos
                          ? '/pUno_latinoamerica_feedback_tarea_dos'
                          : '/pUno_latinoamerica_tarea_dos',
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
                const SizedBox(height: 20),
                if (tareaUno && tareaDos && timerEnded)
                  CardButton(
                    iconSize: isMobile ? 30 : 50,
                    text: 'Feed de imágenes\nLatinoamérica',
                    cardWidth: isMobile ? width : widthTablet,
                    cardHeight: height,
                    namedRoute: '/pUno_latinoamerica_feed',
                    backgroundColor: ThemeColors.green,
                    icon: Icons.image,
                    shadowColor: ThemeColors.green,
                  )
                else if (tareaUno && tareaDos)
                  Card(
                    shadowColor: ThemeColors.grayLight,
                    elevation: 3,
                    color: Colors.white,
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
