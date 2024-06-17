import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PUnoEventoCulturalMenu extends StatefulWidget {
  const PUnoEventoCulturalMenu({super.key});

  @override
  State<PUnoEventoCulturalMenu> createState() => _PUnoEventoCulturalMenuState();
}

class _PUnoEventoCulturalMenuState extends State<PUnoEventoCulturalMenu> {
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
        await UnoTasksCompletedService.getUnoEventoTaskCompletedInfo();

    setState(() {
      tareaUno = resultado;
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await UnoTasksCompletedService.isLoadind("artistasTareaUnoCompleted");
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
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, size: isMobile ? 20 : 40),
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
            Strings.titleEventoCulturalUno,
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
                  text: isLoadingTarea
                      ? 'Cargando\nCrear Evento Cultural'
                      : tareaUno
                          ? 'Feedback\nCrear Evento Cultural'
                          : 'Crear Evento Cultural',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pUno_evento_cultural_feedback'
                          : '/pUno_criacao_evento_page',
                  backgroundColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.blue,
                  icon: isLoadingTarea
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.record_voice_over,
                  shadowColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
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
