import 'package:flutter/material.dart';
import 'package:proyectemos/services/tres_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PTresLaSociedadtMenu extends StatefulWidget {
  const PTresLaSociedadtMenu({super.key});

  @override
  State<PTresLaSociedadtMenu> createState() => _PTresLaSociedadtMenuState();
}

class _PTresLaSociedadtMenuState extends State<PTresLaSociedadtMenu> {
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
        await TresTasksCompletedService.getTresLaSociedadCompletedInfo();

    setState(() {
      tareaUno = resultado;
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await UnoTasksCompletedService.isLoadind("laSociedadTareaCompleted");
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
            onPressed: () => Navigator.pushNamed(context, '/proyecto_tres'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleLaSociedad,
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
                      ? 'Cargando\nLa Sociedad'
                      : tareaUno
                          ? 'Feedback La Sociedad'
                          : 'La Sociedad',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pTres_laSociedad_feedback'
                          : '/pTres_laSociedad',
                  backgroundColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
                          ? ThemeColors.green
                          : ThemeColors.red,
                  icon: isLoadingTarea
                      ? Icons.hourglass_bottom_outlined
                      : tareaUno
                          ? Icons.check
                          : Icons.record_voice_over,
                  shadowColor: isLoadingTarea
                      ? ThemeColors.grayLight
                      : tareaUno
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
