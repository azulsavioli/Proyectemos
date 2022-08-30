import 'package:flutter/material.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class TarefasCompletasPage extends StatefulWidget {
  const TarefasCompletasPage({Key? key}) : super(key: key);

  @override
  State<TarefasCompletasPage> createState() => _TarefasCompletasPageState();
}

class _TarefasCompletasPageState extends State<TarefasCompletasPage> {
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
        body: const Center(
            child: Text(
          'Tarefas Cumplidas',
          style: ThemeText.paragraph14Blue,
        )),
      ),
    );
  }
}
