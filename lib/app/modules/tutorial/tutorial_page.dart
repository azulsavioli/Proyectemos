import 'package:flutter/material.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
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
          title: const Text(Strings.titleTutorialesPage,
              style: ThemeText.paragraph16WhiteBold),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: const Center(
            child: Text(
          'Tutoriales',
          style: ThemeText.paragraph14Blue,
        )),
      ),
    );
  }
}
