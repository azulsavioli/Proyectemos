import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/card_button.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class ProyectoUnoPage extends StatelessWidget {
  const ProyectoUnoPage({Key? key}) : super(key: key);

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
          automaticallyImplyLeading: true,
          title: const Text(Strings.titleCardUno,
              style: ThemeText.paragraph16WhiteBold),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset(Strings.proyectoUno)),
                ),
                CardButton(
                  iconSize: 35,
                  text: 'Latinoamérica',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_latinoamerica_tarea_uno',
                  backgroundColor: ThemeColors.red,
                  icon: Icons.person,
                  shadowColor: ThemeColors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 35,
                  text: 'Artistas\nhispanoamericanos',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_artistas_latinoamericanos_tarea_uno',
                  backgroundColor: ThemeColors.blue,
                  icon: Icons.group,
                  shadowColor: ThemeColors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 35,
                  text: 'Evento Cultural',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_latinoamerica_tarea_uno',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.group_add,
                  shadowColor: ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 35,
                  text: 'Divulgación',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_latinoamerica_tarea_uno',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.group_add,
                  shadowColor: ThemeColors.yellow,
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
