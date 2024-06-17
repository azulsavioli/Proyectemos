import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/card_button.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../../../services/dos_tasks_completed.dart';
import '../widgets/drawer_menu.dart';

class ProyectoDosPage extends StatefulWidget {
  const ProyectoDosPage({Key? key}) : super(key: key);

  @override
  State<ProyectoDosPage> createState() => _ProyectoDosPageState();
}

class _ProyectoDosPageState extends State<ProyectoDosPage> {
  bool conocesPodcastCompleted = false;
  bool comoCrearPodcastCompleted = false;
  bool laEncuestaCompleted = false;
  bool creacionEncuestaCompleted = false;
  bool grabacionPodcastCompleted = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado = await DosTasksCompletedService.getDosTaskCompletedInfo();

    setState(() {
      conocesPodcastCompleted = resultado[0];
      comoCrearPodcastCompleted = resultado[1];
      laEncuestaCompleted = resultado[2];
      creacionEncuestaCompleted = resultado[3];
      grabacionPodcastCompleted = resultado[4];
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
            Strings.titleCardDos,
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
                    child: Image.asset(Strings.proyectoDos),
                  ),
                ),
                CardButton(
                  iconSize:isMobile ? 30 : 50,
                  text: conocesPodcastCompleted
                      ? Strings.titlefeedbackConocesPodcast
                      : Strings.titleConocesPodcast,
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pDos_conocesPodcast_menu',
                  backgroundColor: conocesPodcastCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                  icon: conocesPodcastCompleted ? Icons.check : Icons.person,
                  shadowColor: conocesPodcastCompleted
                      ? ThemeColors.green
                      : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 25 : 45,
                  text: 'Cómo crear un podcast',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pDos_comoCrearPodcast_menu',
                  backgroundColor: comoCrearPodcastCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon:
                      comoCrearPodcastCompleted ? Icons.check : Icons.group_add,
                  shadowColor: comoCrearPodcastCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 30 : 50,
                  text: 'La encuesta',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pDos_laEncuesta_menu',
                  backgroundColor:
                      laEncuestaCompleted ? ThemeColors.green : ThemeColors.red,
                  icon: laEncuestaCompleted ? Icons.check : Icons.person,
                  shadowColor:
                      laEncuestaCompleted ? ThemeColors.green : ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 25 : 45,
                  text: 'Creación de la encuesta',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pDos_creacionEncuesta_menu',
                  backgroundColor: creacionEncuestaCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon:
                      creacionEncuestaCompleted ? Icons.check : Icons.group_add,
                  shadowColor: creacionEncuestaCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: isMobile ? 25 : 45,
                  text: 'Grabación del podcast',
                  cardWidth:  isMobile ? width : widthTablet,
                  cardHeight: height,
                  namedRoute: '/pDos_grabacionPodcast_menu',
                  backgroundColor: grabacionPodcastCompleted
                      ? ThemeColors.green
                      : ThemeColors.yellow,
                  icon:
                      grabacionPodcastCompleted ? Icons.check : Icons.group_add,
                  shadowColor: grabacionPodcastCompleted
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
