import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PUnoDivulgacionMenu extends StatefulWidget {
  const PUnoDivulgacionMenu({super.key});

  @override
  State<PUnoDivulgacionMenu> createState() => _PUnoDivulgacionMenuState();
}

class _PUnoDivulgacionMenuState extends State<PUnoDivulgacionMenu> {
  bool tareaUno = false;
  bool isLoadingTarea = false;
  bool timerEnded = false;

  @override
  void initState() {
    super.initState();
    isTaskOneLoading();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await UnoTasksCompletedService.getUnoDivulgationCompletedInfo();

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
    final isTaskOneLoading = await UnoTasksCompletedService.isLoadind(
        "divulgationTareaUnoCompleted");
    setState(() {
      isLoadingTarea = isTaskOneLoading;
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
            onPressed: () => Navigator.pushNamed(context, '/proyecto_uno'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleDivulgacionUno,
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
                  text: isLoadingTarea
                      ? 'Cargando\nDivulgar Evento Cultural'
                      : tareaUno
                          ? 'Feedback\nDivulgar Evento Cultural'
                          : 'Divulgar Evento Cultural',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pUno_divulgacao_feedback'
                          : '/pUno_divulgacao_page',
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
                if (tareaUno && timerEnded)
                  CardButton(
                    iconSize: 30,
                    text: 'Feed de Eventos Culturales',
                    cardWidth: width,
                    cardHeight: height,
                    namedRoute: '/pUno_feed_divulgacao',
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
