import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSide = (constraints.maxWidth * 0.7).clamp(
          120.0,
          constraints.maxHeight * 0.38,
        );
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              width: constraints.maxWidth,
              color: ThemeColors.blue,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Con la finalidad de poner la lengua española más cerca de tus intereses y realidad,',
                      style: ThemeText.paragraph14WhiteBold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Image.asset(
                      'assets/images/dos_onboarding.png',
                      height: imageSide,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'esta aplicación está dividida en 3 grandes proyectos: proyecto UNO, proyecto DOS y proyecto TRÉS.',
                      style: ThemeText.paragraph14WhiteBold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
