import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_artistas_impl.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/get_user.dart';
import 'intro_tareas_artistas.dart';
import 'question_artistas_one.dart';
import 'question_artistas_three.dart';
import 'question_artistas_two.dart';
import 'tarea_uno_controller.dart';

class TareaArtistasLatinoamericanosPage extends StatefulWidget {
  const TareaArtistasLatinoamericanosPage({Key? key}) : super(key: key);

  @override
  State<TareaArtistasLatinoamericanosPage> createState() =>
      _TareaArtistasLatinoamericanosPageState();
}

class _TareaArtistasLatinoamericanosPageState
    extends State<TareaArtistasLatinoamericanosPage> {
  final isAudioFinish = RecordAudioArtistasProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioArtistasProviderImpl.recordingsPaths;
  final _controller = ArtistasLatinoamericanosTareaUnoController();
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final pageController = PageController();

  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          toolbarHeight: isMobile ? 60 : 110,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: ThemeColors.white, size: isMobile ? 20 : 50),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            Strings.titleArtistasHispanoamericanosUno,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 90,
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        pageChanged = index;
                      });
                    },
                    controller: pageController,
                    children: [
                      IntroTareaUnoArtistasHispanoamericanosPage(
                        controller: _controller,
                      ),
                      QuestionArtistashispanoamericanosOne(
                        controller: _controller,
                      ),
                      QuestionArtistashispanoamericanosTwo(
                        controller: _controller,
                      ),
                      QuestionArtistashispanoamericanosThree(
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )),
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
                              WidgetStateProperty.all<Color>(ThemeColors.blue),
                        ),
                        onPressed: () async {
                          final currentUser = getCurrentUser(context);

                          if (recordsPathList.isEmpty ||
                              recordsPathList.length < 3) {
                            showToast(
                              '''
      ¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!
      ''',
                              color: ThemeColors.red,
                              textColor: ThemeColors.white,
                            );
                          } else {
                            if (recordsPathList.isNotEmpty &&
                                recordsPathList.length == 3) {
                              setState(() {
                                loading = true;
                              });
                              Future.delayed(Duration(milliseconds: 2000)).then(
                                (value) => Navigator.pushNamed(
                                  context,
                                  '/pUno_artistas_menu',
                                ),
                              );
                              _controller.sendAnswers(
                                currentUser,
                                recordsPathList,
                              );
                            }
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
      ),
    );
  }
}
