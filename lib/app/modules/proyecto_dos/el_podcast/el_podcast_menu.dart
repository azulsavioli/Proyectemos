import 'package:flutter/material.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/uno_tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class PDosConocesPodcastMenu extends StatefulWidget {
  const PDosConocesPodcastMenu({super.key});

  @override
  State<PDosConocesPodcastMenu> createState() => _PDosConocesPodcastMenuState();
}

class _PDosConocesPodcastMenuState extends State<PDosConocesPodcastMenu> {
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
        await DosTasksCompletedService.getDosConocesPodcastTaskCompletedInfo();

    setState(() {
      tareaUno = resultado;
    });
  }

  Future<void> isTaskOneLoading() async {
    final isTaskOneLoading =
        await UnoTasksCompletedService.isLoadind("conocesPodcastCompleted");
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
            onPressed: () => Navigator.pushNamed(context, '/proyecto_dos'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleConocesPodcast,
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
                      ? 'Cargando\nConoces el podcast'
                      : tareaUno
                          ? 'Feedback\nConoces el podcast'
                          : 'Conoces el podcast',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: isLoadingTarea
                      ? null
                      : tareaUno
                          ? '/pDos_conocesPodcast_feedback'
                          : '/pDos_conocesPodcast',
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
