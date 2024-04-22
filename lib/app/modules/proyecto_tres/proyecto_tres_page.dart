import 'package:flutter/material.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../../../services/tres_tasks_completed.dart';
import '../widgets/card_button.dart';
import '../widgets/drawer_menu.dart';

class ProyectoTresPage extends StatefulWidget {
  const ProyectoTresPage({Key? key}) : super(key: key);

  @override
  State<ProyectoTresPage> createState() => _ProyectoTresPageState();
}

class _ProyectoTresPageState extends State<ProyectoTresPage> {
  bool laSociedadCompleted = false;
  bool movimientosSocialesCompleted = false;
  bool tuAlrededorCompleted = false;
  bool lasRedesSocialesYElActivismoCompleted = false;
  bool creacionDeSuMovimentoCompleted = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await TresTasksCompletedService.getTresTaskCompletedInfo();

    setState(() {
      laSociedadCompleted = resultado[0];
      movimientosSocialesCompleted = resultado[1];
      tuAlrededorCompleted = resultado[2];
      lasRedesSocialesYElActivismoCompleted = resultado[3];
      creacionDeSuMovimentoCompleted = resultado[4];
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
            onPressed: () => Navigator.pushNamed(context, '/proyectos'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleCardTres,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(Strings.proyectoTres),
                  ),
                ),
                CardButton(
                  iconSize: 30,
                  text: laSociedadCompleted
                      ? 'Feedback La Sociedad'
                      : 'La Sociedad',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: laSociedadCompleted
                      ? '/pTres_laSociedad_feedback_tarea_uno'
                      : '/pTres_laSociedad',
                  backgroundColor:
                      laSociedadCompleted ? ThemeColors.green : ThemeColors.red,
                  icon: laSociedadCompleted ? Icons.check : Icons.person,
                  shadowColor:
                      laSociedadCompleted ? ThemeColors.green : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: 'Movimientos\nSociales',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: movimientosSocialesCompleted
                      ? '/pTres_movimientosSociales_tarea_menu'
                      : '/pTres_movimientosSociales',
                  backgroundColor: movimientosSocialesCompleted
                      ? ThemeColors.green
                      : ThemeColors.blue,
                  icon:
                      movimientosSocialesCompleted ? Icons.check : Icons.group,
                  shadowColor: movimientosSocialesCompleted
                      ? ThemeColors.green
                      : ThemeColors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 25,
                  text: tuAlrededorCompleted
                      ? 'Feedback\nTu Alrededor'
                      : 'Tu Alrededor',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tuAlrededorCompleted
                      ? '/pTres_tuAlrededor_feedback'
                      : '/pTres_tuAlrededor',
                  backgroundColor: tuAlrededorCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                  icon: tuAlrededorCompleted ? Icons.check : Icons.person,
                  shadowColor: tuAlrededorCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 25,
                  text: 'Crea tu movimiento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pTres_creacionDeSuMovimento_menu',
                  backgroundColor: creacionDeSuMovimentoCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon: creacionDeSuMovimentoCompleted
                      ? Icons.check
                      : Icons.group_add,
                  shadowColor: creacionDeSuMovimentoCompleted
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
