import 'package:flutter/material.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/card_proyects.dart';
import '../widgets/drawer_menu.dart';

class ProyectosPage extends StatelessWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  void goTo(BuildContext context, String namedRoute) {
    Navigator.pushNamed(context, namedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Image.asset(
            Strings.logo,
            height: 10,
            width: 10,
            scale: 18,
          ),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(Strings.title, style: ThemeText.paragraph16WhiteBold),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardProyecto(
                  image: Strings.imageUno,
                  title: Strings.titleCardUno,
                  titleColor: ThemeText.h3title20Red,
                  description: Strings.descriptionCardUno,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.red,
                  namedRoute: '/proyecto_uno',
                ),
                const SizedBox(
                  height: 20,
                ),
                CardProyecto(
                  image: Strings.imageDos,
                  title: Strings.titleCardDos,
                  titleColor: ThemeText.h3title20Blue,
                  description: Strings.descriptionCardDos,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.blue,
                  namedRoute: '/proyecto_dos',
                ),
                const SizedBox(
                  height: 20,
                ),
                CardProyecto(
                  image: Strings.imageTres,
                  title: Strings.titleCardTres,
                  titleColor: ThemeText.h3title20yellow,
                  description: Strings.descriptionCardDos,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.yellow,
                  namedRoute: '/proyecto_tres',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
