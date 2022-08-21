import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(254, 147, 28, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 12, right: 12),
              child: Image.asset(
                'assets/images/tres_onboarding.png',
                height: MediaQuery.of(context).size.width * .7,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 8),
              child: Text(
                "¡Deseamos que los momentos en la aplicación !PROYECTEMOS! sean una experiencia significativa y transformadora! ",
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(250, 251, 250, 1),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
