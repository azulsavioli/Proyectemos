import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '!Bienvenidos!',
              style: ThemeText.h1title45WhiteBold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
              child: Image.asset(
                'assets/images/uno_onboarding.png',
                height: MediaQuery.of(context).size.width * .7,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 22,
                right: 22,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '''Esta aplicación ha sido pensada como un lugar para explorar tu creatividad, para encuentros e interacciones con tus compañeros(as) y profesores(as).''',
                    style: ThemeText.paragraph16WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
