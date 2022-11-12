import 'package:flutter/material.dart';

import '../../../commons/styles.dart';
import '../widgets/card_proyects.dart';
import '../widgets/drawer_menu.dart';
import '../../../commons/strings.dart';

class ProyectosPage extends StatelessWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  goTo(context, namedRoute) {
    Navigator.pushNamed(context, namedRoute);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.width * .4;

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
          automaticallyImplyLeading: true,
          title:
              const Text(Strings.title, style: ThemeText.paragraph16WhiteBold),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CardProyecto(
                  image: Strings.imageUno,
                  title: Strings.titleCardUno,
                  titleColor: ThemeText.h3title22Red,
                  description: Strings.descriptionCardUno,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.red,
                  namedRoute: '/proyecto_uno',
                ),
                SizedBox(
                  height: 30,
                ),
                CardProyecto(
                  image: Strings.imageDos,
                  title: Strings.titleCardDos,
                  titleColor: ThemeText.h3title22Blue,
                  description: Strings.descriptionCardDos,
                  descriptionColor: ThemeText.paragraph14Gray,
                  backgroundColor: ThemeColors.blue,
                  namedRoute: '/proyecto_dos',
                ),
                SizedBox(
                  height: 30,
                ),
                CardProyecto(
                  image: Strings.imageTres,
                  title: Strings.titleCardTres,
                  titleColor: ThemeText.h3title22yellow,
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
