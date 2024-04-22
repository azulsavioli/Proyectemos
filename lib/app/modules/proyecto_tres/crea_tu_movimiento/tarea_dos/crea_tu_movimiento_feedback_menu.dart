import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/card_button.dart';
import '../../../widgets/drawer_menu.dart';

class FeedbackCreacionDeSuMovimentoMenu extends StatefulWidget {
  const FeedbackCreacionDeSuMovimentoMenu({super.key});

  @override
  State<FeedbackCreacionDeSuMovimentoMenu> createState() =>
      _FeedbackCreacionDeSuMovimentoMenuState();
}

class _FeedbackCreacionDeSuMovimentoMenuState
    extends State<FeedbackCreacionDeSuMovimentoMenu> {
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
                  text: 'Feed\nCrea tu movimiento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pTres_feed_creacionDeSuMovimento_tarea_dos',
                  backgroundColor: ThemeColors.yellow,
                  icon: Icons.music_note_sharp,
                  shadowColor: ThemeColors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
                CardButton(
                  iconSize: 30,
                  text: 'Feedback\nCrea tu movimiento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/pTres_feedback_creacionDeSuMovimento_tarea_dos',
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
