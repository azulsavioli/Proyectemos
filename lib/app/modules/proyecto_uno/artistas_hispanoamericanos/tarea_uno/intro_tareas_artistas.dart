import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_artistas_latinoamericanos.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_carousel.dart';
import 'tarea_uno_controller.dart';

class IntroTareaUnoArtistasHispanoamericanosPage extends StatefulWidget {
  final ArtistasLatinoamericanosTareaUnoController controller;

  const IntroTareaUnoArtistasHispanoamericanosPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<IntroTareaUnoArtistasHispanoamericanosPage> createState() =>
      _IntroTareaUnoArtistasHispanoamericanosPageState();
}

class _IntroTareaUnoArtistasHispanoamericanosPageState
    extends State<IntroTareaUnoArtistasHispanoamericanosPage> {
  ArtistasLatinoamericanosTareaUnoController get controller =>
      widget.controller;
  bool loading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });

    super.initState();
  }

  final imgList = [
    'https://firebasestorage.googleapis.com/v0/b/proyectemos-9924c.appspot.com/o/Frida%20Kahlo%2FImagem1.jpg?alt=media&token=18fc7cff-a57d-499a-ae2d-ae0acc3aefc0',
    'https://firebasestorage.googleapis.com/v0/b/proyectemos-9924c.appspot.com/o/Frida%20Kahlo%2Fcoluna-partida-cke.gif?alt=media&token=900cf070-6780-40c1-b1e2-4ae5a7b7b60d',
    'https://firebasestorage.googleapis.com/v0/b/proyectemos-9924c.appspot.com/o/Frida%20Kahlo%2Fo-veado-ferido-cke.webp?alt=media&token=a1b44015-c55b-434b-ad36-28732724bccf',
    'https://firebasestorage.googleapis.com/v0/b/proyectemos-9924c.appspot.com/o/Frida%20Kahlo%2Fsem_esperanci_a_1945_c.webp?alt=media&token=b4d33dd0-98d1-45db-8d02-184a9e78c969',
  ];

  final imgNameList = [
    'Autorretrato con collar de espinas, 1940',
    'La columna rota, 1944',
    'El venado herido, 1946',
    'Desesperado, 1945',
  ];

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Frida Kahlo',
                style: ThemeText.h3title20Blue,
              ),
            ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            if (loading)
              SizedBox(
                height: isMobile ? 300 : 500,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: ThemeColors.yellow,
                  ),
                ),
              )
            else
              CustomCarousel(
                imgList: imgList,
                imgNameList: imgNameList,
              ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Padding(
              padding: isMobile
                  ? EdgeInsets.symmetric(horizontal: 12)
                  : EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                StringsArtistasLationamerica.titleQOnePageOneArtistasLatin,
                style: ThemeText.paragraph14Gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
