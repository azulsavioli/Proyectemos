import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/drawer_menu.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';
import 'package:proyectemos/services/tres_tasks_completed.dart';

import '../../../services/uno_tasks_completed.dart';
import '../widgets/card_proyects.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  bool latinoamericaCompleted = false;
  bool artistasCompleted = false;
  bool eventoCulturalCompleted = false;
  bool divulgationCompleted = false;

  bool conocesPodcast = false;
  bool comoCrearPodcast = false;
  bool laEncuesta = false;
  bool creacionEncuesta = false;
  bool grabacionPodcast = false;

  bool laSociedad = false;
  bool movimientosSociales = false;
  bool tuAlrededor = false;
  bool creaTuMovimiento = false;

  late bool isUnoCompleted;
  late bool isDosCompleted;
  late bool isTresCompleted;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
    setState(() {
      isUnoCompleted = latinoamericaCompleted &&
          artistasCompleted &&
          eventoCulturalCompleted &&
          divulgationCompleted;

      isDosCompleted = conocesPodcast &&
          comoCrearPodcast &&
          laEncuesta &&
          creacionEncuesta &&
          grabacionPodcast;

      isTresCompleted =
          laSociedad && movimientosSociales && tuAlrededor && creaTuMovimiento;
    });
  }

  Future<void> getTaskCompleted() async {
    final resultadoUno =
        await UnoTasksCompletedService.getUnoTaskCompletedInfo();
    final resultadoDos =
        await DosTasksCompletedService.getDosTaskCompletedInfo();
    final resultadoTres =
        await TresTasksCompletedService.getTresTaskCompletedInfo();

    setState(() {
      latinoamericaCompleted = resultadoUno[0];
      artistasCompleted = resultadoUno[1];
      eventoCulturalCompleted = resultadoUno[2];
      divulgationCompleted = resultadoUno[3];

      conocesPodcast = resultadoDos[0];
      comoCrearPodcast = resultadoDos[1];
      laEncuesta = resultadoDos[2];
      creacionEncuesta = resultadoDos[3];
      grabacionPodcast = resultadoDos[4];

      laSociedad = resultadoTres[0];
      movimientosSociales = resultadoTres[1];
      tuAlrededor = resultadoTres[2];
      creaTuMovimiento = resultadoTres[3];

      isUnoCompleted = latinoamericaCompleted &&
          artistasCompleted &&
          eventoCulturalCompleted &&
          divulgationCompleted;

      isDosCompleted = conocesPodcast &&
          comoCrearPodcast &&
          laEncuesta &&
          creacionEncuesta &&
          grabacionPodcast;

      isTresCompleted =
          laSociedad && movimientosSociales && tuAlrededor && creaTuMovimiento;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: ThemeColors.gray,
          ),
          backgroundColor: ThemeColors.white,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.png',
              height: 10,
              width: 10,
            ),
          ),
          title: Text(
            Strings.title,
            style: ThemeText.h3title20BlueBold,
          ),
        ),
        backgroundColor: ThemeColors.white,
        endDrawer: DrawerMenuWidget(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardProyecto(
                  image: Strings.imageUno,
                  title: Strings.titleCardUno,
                  titleColor: ThemeText.h3title20Red,
                  description: Strings.descriptionCardUno,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.red,
                  namedRoute: '/proyecto_uno',
                  icon: isUnoCompleted ? Icons.check : null,
                ),
                SizedBox(height: 20),
                CardProyecto(
                  image: Strings.imageDos,
                  title: Strings.titleCardDos,
                  titleColor: ThemeText.h3title20Blue,
                  description: Strings.descriptionCardDos,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.blue,
                  namedRoute: '/proyecto_dos',
                  icon: isDosCompleted ? Icons.check : null,
                ),
                SizedBox(height: 20),
                CardProyecto(
                  image: Strings.imageTres,
                  title: Strings.titleCardTres,
                  titleColor: ThemeText.h3title20yellow,
                  description: Strings.descriptionCardDos,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.yellow,
                  namedRoute: '/proyecto_tres',
                  icon: isTresCompleted ? Icons.check : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
