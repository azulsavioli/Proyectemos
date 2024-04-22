import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/card_button.dart';
import '../../../widgets/drawer_menu.dart';

class FeedbackMenuMovimientosSociales extends StatefulWidget {
  const FeedbackMenuMovimientosSociales({super.key});

  @override
  State<FeedbackMenuMovimientosSociales> createState() =>
      _FeedbackMenuMovimientosSocialesState();
}

class _FeedbackMenuMovimientosSocialesState
    extends State<FeedbackMenuMovimientosSociales> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .99;
    final height = MediaQuery.of(context).size.width * .4;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pushNamed(context, '/proyecto_tres'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleCreaTuMovimiento,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
        endDrawer: DrawerMenuWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: 'Feed\nMovimientos Sociales',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pTres_movimientosSociales_feed',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.music_note_sharp,
                  shadowColor: ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: 'Feedback\nMovimientos Sociales',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pTres_movimientosSociales_feedback',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.image,
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
