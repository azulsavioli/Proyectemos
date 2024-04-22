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

  @override
  void initState() {
    super.initState();
    getTask();
  }

  Future<void> getTask() async {
    final resultado = await TresTasksCompletedService
        .getTresCreacionDeSuMovimentoCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
      tareaDos = resultado[1];
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
                  text: tareaUno
                      ? 'Feedback\nNuestro movimiento social'
                      : 'Nuestro movimiento social',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pTres_feedback_creacionDeSuMovimento_tarea_uno'
                      : '/pTres_creacionDeSuMovimento_tarea_uno',
                  backgroundColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
                  icon: tareaUno ? Icons.check : Icons.music_note_sharp,
                  shadowColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: tareaDos
                      ? 'Feedback\nLa red social del movimento'
                      : 'La red social del movimento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaDos
                      ? '/pTres_feedback_creacionDeSuMovimento_tarea_dos_menu'
                      : '/pTres_creacionDeSuMovimento_tarea_dos',
                  backgroundColor:
                      tareaDos ? ThemeColors.green : ThemeColors.yellow,
                  icon: tareaDos ? Icons.check : Icons.image,
                  shadowColor:
                      tareaDos ? ThemeColors.green : ThemeColors.yellow,
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
