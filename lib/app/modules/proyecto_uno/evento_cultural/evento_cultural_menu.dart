import 'package:flutter/material.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../services/tasks_completed.dart';
import '../../widgets/card_button.dart';
import '../../widgets/drawer_menu.dart';

class EventoCulturalMenu extends StatefulWidget {
  const EventoCulturalMenu({super.key});

  @override
  State<EventoCulturalMenu> createState() => _EventoCulturalMenuState();
}

class _EventoCulturalMenuState extends State<EventoCulturalMenu> {
  bool tareaUno = false;

  @override
  void initState() {
    super.initState();
    getTaskCompleted();
  }

  Future<void> getTaskCompleted() async {
    final resultado =
        await TasksCompletedService.getUnoEventoTaskCompletedInfo();

    setState(() {
      tareaUno = resultado[0];
    });
  }

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
          title: Text(
            Strings.titleEventoCulturalUno,
            style: ThemeText.paragraph16WhiteBold,
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
                  text: 'Creación de un evento',
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: tareaUno
                      ? '/pUno_evento_cultural_feedback'
                      : '/pUno_criacao_evento_page',
                  backgroundColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
                  icon: tareaUno ? Icons.check : Icons.group_add,
                  shadowColor:
                      tareaUno ? ThemeColors.green : ThemeColors.yellow,
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
