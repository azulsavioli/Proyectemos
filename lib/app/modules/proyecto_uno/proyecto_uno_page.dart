import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/card_button.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../../../services/uno_tasks_completed.dart';
import '../widgets/drawer_menu.dart';

class ProyectoUnoPage extends StatefulWidget {
  const ProyectoUnoPage({Key? key}) : super(key: key);

  @override
  State<ProyectoUnoPage> createState() => _ProyectoUnoPageState();
}

class _ProyectoUnoPageState extends State<ProyectoUnoPage> {
  bool latinoamericaCompleted = false;
  bool artistasCompleted = false;
  bool eventoCulturalCompleted = false;
  bool divulgationCompleted = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado = await UnoTasksCompletedService.getUnoTaskCompletedInfo();

    setState(() {
      latinoamericaCompleted = resultado[0];
      artistasCompleted = resultado[1];
      eventoCulturalCompleted = resultado[2];
      divulgationCompleted = resultado[3];
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
              onPressed: () => Navigator.pushNamed(context, '/proyectos'),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleCardUno,
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
                    child: Image.asset(Strings.proyectoUno),
                  ),
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: 'Latinoamérica',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pUno_latinoamerica_menu',
                  backgroundColor: latinoamericaCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                  icon: latinoamericaCompleted ? Icons.check : Icons.person,
                  shadowColor: latinoamericaCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: 'Artistas\nhispanoamericanos',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pUno_artistas_menu',
                  backgroundColor:
                      artistasCompleted ? ThemeColors.green : ThemeColors.blue,
                  icon: artistasCompleted ? Icons.check : Icons.group,
                  shadowColor:
                      artistasCompleted ? ThemeColors.green : ThemeColors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 25 : 45,
                  text: 'Evento Cultural',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pUno_evento_cultural_menu',
                  backgroundColor: eventoCulturalCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon: eventoCulturalCompleted ? Icons.check : Icons.group_add,
                  shadowColor: eventoCulturalCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 25 : 45,
                  text: 'Divulgación',
                  cardWidth: isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pUno_divulgacao_menu',
                  backgroundColor: divulgationCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon: divulgationCompleted ? Icons.check : Icons.group_add,
                  shadowColor: divulgationCompleted
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
