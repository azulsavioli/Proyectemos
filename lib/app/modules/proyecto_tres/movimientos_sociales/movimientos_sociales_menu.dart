import 'package:flutter/material.dart';
import 'package:proyectemos/services/tres_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PTresMovimientosSocialestMenu extends StatefulWidget {
  const PTresMovimientosSocialestMenu({super.key});

  @override
  State<PTresMovimientosSocialestMenu> createState() =>
      _PTresMovimientosSocialestMenuState();
}

class _PTresMovimientosSocialestMenuState
    extends State<PTresMovimientosSocialestMenu> {
  bool tareaUno = false;
  bool timerEnded = false;
  bool isLoadingTarea = false;

  @override
  void initState() {
    super.initState();
    isTaskOneLoading();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado = await TresTasksCompletedService
        .getTresMovimientosSocialesCompletedInfo();

    setState(() {
      tareaUno = resultado;
    });

    if (tareaUno) {
      await Future.delayed(
        const Duration(seconds: 3),
        () => setState(() => timerEnded = true),
      );
    }
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading = await TresTasksCompletedService.isLoadind(
        "movimientosSocialesCompleted");
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
            Strings.movimientoSociale,
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
                      ? 'Cargando\nMovimientos Sociales'
                      : tareaUno
                          ? 'Feedback\nMovimientos sociales'
                          : 'Movimientos sociales',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pTres_movimientosSociales_feedback'
                          : '/pTres_movimientosSociales',
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
                if (tareaUno && timerEnded)
                  CardButton(
                    iconSize: isMobile ? 30 : 50,
                    text: 'Feed de videos\ncompartidos',
                    cardWidth: isMobile ? width : widthTablet,
                    cardHeight: height,
                    namedRoute: '/pTres_movimientosSociales_feed',
                    backgroundColor: ThemeColors.green,
                    icon: Icons.image,
                    shadowColor: ThemeColors.green,
                  )
                else if (tareaUno)
                  Card(
                    shadowColor: ThemeColors.grayLight,
                    elevation: 3,
                    color: Colors.white,
                    child: SizedBox(
                      height: height,
                      width: isMobile ? width : widthTablet,
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
