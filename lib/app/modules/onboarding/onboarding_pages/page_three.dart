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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageHeight = (width * .7).clamp(180.0, height * .42).toDouble();

    return Container(
      width: width,
      height: height,
      color: ThemeColors.yellow,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 22,
                  right: 22,
                  bottom: 4,
                ),
                child: Text(
                  '¡Deseamos que los momentos en la aplicación !PROYECTEMOS!',
                  style: ThemeText.paragraph14WhiteBold,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                child: Image.asset(
                  'assets/images/tres_onboarding.png',
                  height: imageHeight,
                  width: width * .8,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 22,
                  right: 22,
                  bottom: 4,
                ),
                child: Text(
                  'sean una experiencia significativa y transformadora!',
                  style: ThemeText.paragraph14WhiteBold,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
