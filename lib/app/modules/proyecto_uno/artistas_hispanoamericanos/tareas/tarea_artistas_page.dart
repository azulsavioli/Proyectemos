import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/drawer_menu.dart';
import '../artistas_controller.dart';
import 'intro_tareas_artistas.dart';
import 'question_artistas_one.dart';
import 'question_artistas_three.dart';
import 'question_artistas_two.dart';

class TareaArtistasLatinoamericanosPage extends StatefulWidget {
  const TareaArtistasLatinoamericanosPage({Key? key}) : super(key: key);

  @override
  State<TareaArtistasLatinoamericanosPage> createState() =>
      _TareaArtistasLatinoamericanosPageState();
}

class _TareaArtistasLatinoamericanosPageState
    extends State<TareaArtistasLatinoamericanosPage> {
  final _artistasController = ArtistasLatinoamericanosController();

  final formKey = GlobalKey<FormState>();
  final pageController = PageController();

  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titleArtistasHispanoamericanos,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
        },
        controller: pageController,
        children: [
          IntroTareaArtistasHispanoamericanosPage(
            controller: _artistasController,
          ),
          QuestionArtistashispanoamericanosOne(
            controller: _artistasController,
          ),
          QuestionArtistashispanoamericanosTwo(
            controller: _artistasController,
          ),
          QuestionArtistashispanoamericanosThree(
            controller: _artistasController,
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (pageChanged == 0)
              const SizedBox(
                width: 65,
              )
            else
              TextButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.blueAccent,
                  dotColor: Colors.black26,
                ),
              ),
            ),
            if (pageChanged == 3)
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ThemeColors.blue),
                ),
                onPressed: () {},
                child: const Text(
                  'Concluir',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              TextButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  'Próximo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
