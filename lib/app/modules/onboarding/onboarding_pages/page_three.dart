import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

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
              color: ThemeColors.yellow,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '¡Deseamos que los momentos en la aplicación !PROYECTEMOS!',
                      style: ThemeText.paragraph14WhiteBold.copyWith(
                        color: ThemeColors.nearBlack,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Image.asset(
                      'assets/images/tres_onboarding.png',
                      height: imageSide,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'sean una experiencia significativa y transformadora!',
                      style: ThemeText.paragraph14WhiteBold.copyWith(
                        color: ThemeColors.nearBlack,
                      ),
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
