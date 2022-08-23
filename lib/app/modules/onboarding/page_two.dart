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
    return Container(
      color: ThemeColors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Image.asset(
                'assets/images/dos_onboarding.png',
                height: MediaQuery.of(context).size.width * .7,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 8),
              child: Center(
                child: Text(
                  "Con la finalidad de poner la lengua española más cerca de tus intereses y realidad, esta aplicación está dividida en 3 grandes proyectos: proyecto UNO, proyecto DOS y proyecto TRÉS.",
                  style: ThemeText.title20White,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
