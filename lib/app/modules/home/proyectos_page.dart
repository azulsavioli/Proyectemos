import 'package:flutter/material.dart';

import '../widgets/drawer_menu.dart';

class ProyectosPage extends StatelessWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'assets/images/logo.png',
          height: 10,
          width: 10,
          scale: 18,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          '¡Proyectemos!',
          style: TextStyle(
              fontSize: 20,
              letterSpacing: 1,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(250, 251, 250, 1),
              fontWeight: FontWeight.bold),
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: Container(),
    ));
  }
}
