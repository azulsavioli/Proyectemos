import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.yellow,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 8),
              child: Text(
                "¡Deseamos que los momentos en la aplicación !PROYECTEMOS!",
                style: ThemeText.paragraph16WhiteBold,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
              child: Image.asset(
                'assets/images/tres_onboarding.png',
                height: MediaQuery.of(context).size.width * .7,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 8),
              child: Text(
                "sean una experiencia significativa y transformadora! ",
                style: ThemeText.paragraph16WhiteBold,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
