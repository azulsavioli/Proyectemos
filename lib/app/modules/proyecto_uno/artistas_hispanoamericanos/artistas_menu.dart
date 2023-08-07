import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/strings.dart';
import '../../../../services/tasks_completed.dart';
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

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await TasksCompletedService.getUnoArtistasTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
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
            Strings.titleArtistasHispanoamericanos,
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
                  text: tareaUno ? 'Feedback Frida Kahlo' : 'Frida Kahlo',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pUno_artistas_feedback_tarea_uno'
                      : '/pUno_artistas_frida',
                  backgroundColor:
                      tareaUno ? ThemeColors.green : ThemeColors.blue,
                  icon: tareaUno ? Icons.check : Icons.record_voice_over,
                  shadowColor: tareaUno ? ThemeColors.green : ThemeColors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: tareaDos
                      ? 'Feedback\nSelección de archivos'
                      : 'Selección de archivos',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaDos
                      ? '/pUno_artistas_feedback_tarea_dos'
                      : '/pUno_artistas_tarea_dos',
                  backgroundColor:
                      tareaDos ? ThemeColors.green : ThemeColors.blue,
                  icon: tareaDos ? Icons.check : Icons.file_copy,
                  shadowColor: tareaDos ? ThemeColors.green : ThemeColors.blue,
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
