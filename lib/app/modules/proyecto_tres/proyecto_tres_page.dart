import 'package:flutter/material.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class ProyectoTresPage extends StatefulWidget {
  const ProyectoTresPage({Key? key}) : super(key: key);

  @override
  State<ProyectoTresPage> createState() => _ProyectoTresPageState();
}

class _ProyectoTresPageState extends State<ProyectoTresPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
            onPressed: () => Navigator.pushNamed(context, '/proyectos'),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleCardTres,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
        endDrawer: DrawerMenuWidget(),
        body: Center(
          child: Text(
            'En desarrollo',
            style: ThemeText.h1title45BlueBold,
          ),
        ),
      ),
    );
  }
}
