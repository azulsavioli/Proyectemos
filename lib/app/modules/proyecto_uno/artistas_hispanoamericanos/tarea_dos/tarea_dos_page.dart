import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/question_artistas_dos.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/question_artistas_five.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/question_artistas_four.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/question_artistas_one.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/question_artistas_tres.dart';
import 'package:proyectemos/app/modules/proyecto_uno/artistas_hispanoamericanos/tarea_dos/tarea_dos_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tareas_artistas.dart';

class PUnoArtistasLatinoamericanosTareaDosPage extends StatefulWidget {
  const PUnoArtistasLatinoamericanosTareaDosPage({super.key});

  @override
  State<PUnoArtistasLatinoamericanosTareaDosPage> createState() =>
      _PUnoArtistasLatinoamericanosTareaDosPageState();
}

class _PUnoArtistasLatinoamericanosTareaDosPageState
    extends State<PUnoArtistasLatinoamericanosTareaDosPage> {
  late SharedPreferences sharedPreferences;
  String studentSchoolInfo = '';
  String studentClassRoomInfo = '';
  final _controller = ArtistasLatinoamericanosTareaDosController();

  @override
  void initState() {
    super.initState();
    _controller.generateCountrysList();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final answerUnoController = TextEditingController();
  final answerDosController = TextEditingController();
  final answerTresController = TextEditingController();
  final answerQuatroController = TextEditingController();
  final answerCincoController = TextEditingController();

  bool loading = false;

  final pageController = PageController();

  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titleArtistasHispanoamericanosDos,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
              });
            },
            controller: pageController,
            children: [
              const IntroTareaDosArtistasHispanoamericanosPage(),
              QuestionArtistashispanoamericanosOne(
                controller: _controller,
                textController: answerUnoController,
              ),
              QuestionArtistashispanoamericanosDos(
                controller: _controller,
                textController: answerDosController,
              ),
              QuestionArtistashispanoamericanosTres(
                controller: _controller,
                textController: answerTresController,
              ),
              QuestionArtistashispanoamericanosFour(
                controller: _controller,
                textController: answerQuatroController,
              ),
              QuestionArtistashispanoamericanosFive(
                controller: _controller,
                textController: answerCincoController,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: loading
          ? const LinearProgressIndicator(
              minHeight: 20,
              color: ThemeColors.blue,
            )
          : Container(
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
                        'Volver',
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
                      count: 6,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.blueAccent,
                        dotColor: Colors.black26,
                      ),
                    ),
                  ),
                  if (pageChanged == 5)
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(ThemeColors.blue),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            answerUnoController.text.isNotEmpty &&
                            answerDosController.text.isNotEmpty &&
                            answerTresController.text.isNotEmpty &&
                            answerQuatroController.text.isNotEmpty &&
                            answerCincoController.text.isNotEmpty) {
                          setState(() {
                            loading = true;
                          });
                          _controller.sendAnswers(currentUser, [
                            answerUnoController,
                            answerDosController,
                            answerTresController,
                            answerQuatroController,
                            answerCincoController
                          ]).then(
                            (value) => Navigator.pushNamed(
                              context,
                              '/pUno_artistas_menu',
                            ),
                          );
                        } else {
                          showToast(
                            '''Selecciona todos los archivos y escriba sus descripciones''',
                            color: ThemeColors.red,
                            textColor: ThemeColors.white,
                          );
                        }
                      },
                      child: const Text(
                        'Enviar',
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
