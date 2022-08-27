import 'package:flutter/material.dart';

import '../../../commons/styles.dart';
import '../widgets/card_proyects.dart';
import '../widgets/drawer_menu.dart';
import '../../../commons/strings.dart';

class ProyectosPage extends StatelessWidget {
  ProyectosPage({Key? key}) : super(key: key);

  void goTo() {
    return print('ola');
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
          automaticallyImplyLeading: true,
          title: const Text(Strings.title, style: ThemeText.title20White),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardProyecto(
                image: Strings.imageUno,
                title: Strings.titleCardUno,
                titleColor: ThemeText.title20Red,
                description: Strings.descriptionCardUno,
                descriptionColor: ThemeText.paragraph14Gray,
                onCallback: () => goTo,
                backgroundColor: ThemeColors.red,
              ),
              const SizedBox(
                height: 30,
              ),
              CardProyecto(
                image: Strings.imageDos,
                title: Strings.titleCardDos,
                titleColor: ThemeText.title20Blue,
                description: Strings.descriptionCardDos,
                descriptionColor: ThemeText.paragraph14Gray,
                onCallback: () => goTo,
                backgroundColor: ThemeColors.blue,
              ),
              const SizedBox(
                height: 30,
              ),
              CardProyecto(
                image: Strings.imageTres,
                title: Strings.titleCardTres,
                titleColor: ThemeText.title20yellow,
                description: Strings.descriptionCardTres,
                descriptionColor: ThemeText.paragraph14Gray,
                onCallback: () => goTo,
                backgroundColor: ThemeColors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
