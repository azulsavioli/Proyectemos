import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(243, 1, 70, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Image.asset(
                'assets/images/uno_onboarding.png',
                height: MediaQuery.of(context).size.width * .7,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 22, right: 22, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "!Bienvenidos!",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(250, 251, 250, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Esta aplicación ha sido pensada como un lugar para explorar tu creatividad, para encuentros e interacciones con tus compañeros(as) y profesores(as).",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(250, 251, 250, 1),
                        fontWeight: FontWeight.bold),
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
