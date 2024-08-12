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
    'https://citaliarestauro.com/wp-content/uploads/2021/07/Imagem1.jpg',
    'https://cdn.culturagenial.com/imagens/coluna-partida-cke.gif',
    'https://cdn.culturagenial.com/imagens/o-veado-ferido-cke.jpg',
    'https://fridakahlo.site/wp-content/uploads/2022/02/1945-completa-hope2.jpg',
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
      padding: EdgeInsets.all(24),
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
                height: isMobile ? 400 : 500,
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
