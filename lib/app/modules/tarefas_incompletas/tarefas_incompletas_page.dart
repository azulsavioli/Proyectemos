import 'package:flutter/material.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class TarefasIncompletasPage extends StatefulWidget {
  const TarefasIncompletasPage({Key? key}) : super(key: key);

  @override
  State<TarefasIncompletasPage> createState() => _TarefasIncompletasPageState();
}

class _TarefasIncompletasPageState extends State<TarefasIncompletasPage> {
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
          title: const Text(
            Strings.titleTarefasPendentesPage,
            style: ThemeText.paragraph16WhiteBold,
          ),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: const Center(
          child: Text(
            'Tarefas Pendientes',
            style: ThemeText.paragraph14Blue,
          ),
        ),
      ),
    );
  }
}
