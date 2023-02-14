import 'package:flutter/material.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class EventoCulturalPage extends StatelessWidget {
  const EventoCulturalPage({super.key});

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
            onPressed: () => Navigator.pushNamed(context, '/proyecto_uno'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: const Text(
            Strings.titleEventoCulturalUno,
            style: ThemeText.paragraph16WhiteBold,
          ),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 35,
                  text: 'Creación de un evento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_evento_cultural_descricao',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.group_add,
                  shadowColor: ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 35,
                  text: 'La propuesta del evento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pUno_evento_cultural_feedback',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.handshake,
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
