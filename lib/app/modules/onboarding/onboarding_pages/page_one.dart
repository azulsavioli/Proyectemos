import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSide = (constraints.maxWidth * 0.7).clamp(
          120.0,
          constraints.maxHeight * 0.42,
        );
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              width: constraints.maxWidth,
              color: ThemeColors.red,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '!Bienvenidos!',
                    style: ThemeText.h2title35White,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Image.asset(
                      'assets/images/uno_onboarding.png',
                      height: imageSide,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Esta aplicación ha sido pensada como un lugar para explorar tu creatividad, para encuentros e interacciones con tus compañeros(as) y profesores(as).',
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
