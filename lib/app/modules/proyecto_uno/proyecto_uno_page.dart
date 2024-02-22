import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/card_button.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../../../services/uno_tasks_completed.dart';

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
            Strings.titleCardUno,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
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
                  iconSize: 30,
                  text: 'Latinoamérica',
                  cardWidth: width,
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
                  iconSize: 30,
                  text: 'Artistas\nhispanoamericanos',
                  cardWidth: width,
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
                  iconSize: 25,
                  text: 'Evento Cultural',
                  cardWidth: width,
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
                  iconSize: 25,
                  text: 'Divulgación',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: divulgationCompleted
                      ? '/pUno_feed_divulgacao'
                      : '/pUno_divulgacao_page',
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
