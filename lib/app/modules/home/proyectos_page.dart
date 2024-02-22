import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';

import '../../../services/uno_tasks_completed.dart';
import '../profile/profile_page.dart';
import '../widgets/card_proyects.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    _buildBody(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Platform.isAndroid
                  ? Icon(Icons.home)
                  : Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Platform.isAndroid
                  ? Icon(Icons.person)
                  : Icon(CupertinoIcons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

Widget _buildBody() {
  return HomeScreen();
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool latinoamericaCompleted = false;
  bool artistasCompleted = false;
  bool eventoCulturalCompleted = false;
  bool divulgationCompleted = false;
  bool conocesPodcast = false;
  bool comoCrearPodcast = false;
  bool laEncuesta = false;
  bool creacionEncuesta = false;
  bool grabacionPodcast = false;

  late bool isUnoCompleted;
  late bool isDosCompleted;
  bool isTresCompleted = false;

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
    });
  }

  Future<void> getTaskCompleted() async {
    final resultadoUno =
        await UnoTasksCompletedService.getUnoTaskCompletedInfo();
    final resultadoDos =
        await DosTasksCompletedService.getDosTaskCompletedInfo();

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

      isUnoCompleted = latinoamericaCompleted &&
          artistasCompleted &&
          eventoCulturalCompleted &&
          divulgationCompleted;

      isDosCompleted = conocesPodcast &&
          comoCrearPodcast &&
          laEncuesta &&
          creacionEncuesta &&
          grabacionPodcast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                  scale: 1,
                ),
                Text(
                  Strings.title,
                  style: ThemeText.paragraph16BlueBold,
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
          Column(
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
        ],
      ),
    );
  }
}
