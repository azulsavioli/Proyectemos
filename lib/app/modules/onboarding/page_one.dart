import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      color: ThemeColors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '!Bienvenidos!',
            style: ThemeText.h2title35White,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            child: Image.asset(
              'assets/images/uno_onboarding.png',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Esta aplicación ha sido pensada como un lugar para explorar tu creatividad, para encuentros e interacciones con tus compañeros(as) y profesores(as).''',
                  style: ThemeText.paragraph16WhiteBold,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
