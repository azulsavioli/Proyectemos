import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      color: ThemeColors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 22,
              right: 22,
              bottom: 4,
            ),
            child: Text(
              '''Con la finalidad de poner la lengua española más cerca de tus intereses y realidad,''',
              style: ThemeText.paragraph14WhiteBold,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Image.asset(
              'assets/images/dos_onboarding.png',
              height: MediaQuery.of(context).size.width * .7,
              width: MediaQuery.of(context).size.width * .8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 22,
              right: 22,
              bottom: 4,
            ),
            child: Text(
              '''esta aplicación está dividida en 3 grandes proyectos: proyecto UNO, proyecto DOS y proyecto TRÉS.''',
              style: ThemeText.paragraph14WhiteBold,
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
