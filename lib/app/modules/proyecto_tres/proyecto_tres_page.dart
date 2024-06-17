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
      creacionDeSuMovimentoCompleted = resultado[3];
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
                  iconSize: isMobile ? 30 : 50,
                  text: 'La Sociedad',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pTres_laSociedad_menu',
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
                  iconSize: isMobile ? 30 : 50,
                  text: 'Movimientos\nSociales',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pTres_movimientosSociales_menu',
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
                  iconSize: isMobile ? 30 : 50,
                  text: 'Tu Alrededor',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pTres_tuAlrededor_menu',
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
                  iconSize: isMobile ? 25 : 45,
                  text: 'Crea tu movimiento',
                  cardWidth:  isMobile ? width : widthTablet,
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
