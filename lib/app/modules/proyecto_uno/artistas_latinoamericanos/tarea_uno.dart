import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings_artistas_latinoamericanos.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/record_audio_provider.dart';
import '../../widgets/custom_carousel.dart';
import '../../widgets/custom_record_audio_button.dart';
import '../../widgets/drawer_menu.dart';

class PUnoArtistasLatinoamericanosTareaUnoPage extends StatefulWidget {
  const PUnoArtistasLatinoamericanosTareaUnoPage({super.key});

  @override
  State<PUnoArtistasLatinoamericanosTareaUnoPage> createState() =>
      _PUnoArtistasLatinoamericanosTareaUnoPageState();
}

class _PUnoArtistasLatinoamericanosTareaUnoPageState
    extends State<PUnoArtistasLatinoamericanosTareaUnoPage> {
  final imgList = [
    'https://citaliarestauro.com/wp-content/uploads/2021/07/Imagem1.jpg',
    // 'https://fridakahlo.site/wp-content/uploads/2021/04/1940-completa-3-1.jpg',
    'https://cdn.culturagenial.com/imagens/coluna-partida-cke.gif',
    // 'https://fridakahlo.site/wp-content/uploads/2021/04/1944-completa-1-1.jpg',
    'https://cdn.culturagenial.com/imagens/o-veado-ferido-cke.jpg',
    // 'https://fridakahlo.site/wp-content/uploads/2021/04/1946-completa.jpg',
    'https://fridakahlo.site/wp-content/uploads/2022/02/1945-completa-hope2.jpg'
  ];

  final imgNameList = [
    'Autorretrato com Colar de Espinhos, 1940',
    'A coluna quebrada, 1944',
    'O cervo ferido, 1946',
    'Desesperada, 1945'
  ];

  bool loading = false;
  bool recordsDeleted = false;

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
        automaticallyImplyLeading: true,
        title: const Text(Strings.titleArtistasHispanoamericanosUno,
            style: ThemeText.paragraph16WhiteBold),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Frida Kahlo',
                      style: ThemeText.h2title35BlueNormal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomCarousel(imgList: imgList, imgNameList: imgNameList),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    StringsArtistasLationamerica.titleQOnePageOneArtistasLatin,
                    style: ThemeText.paragraph16GrayNormal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    StringsArtistasLationamerica.qOneArtistasLatinPageOne,
                    style: ThemeText.paragraph16GrayBold,
                  ),
                  const CustomRecordAudioButton(
                      question: StringsArtistasLationamerica
                          .qOneArtistasLatinPageOne),
                  const Text(
                    StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
                    style: ThemeText.paragraph16GrayBold,
                  ),
                  const CustomRecordAudioButton(
                      question: StringsArtistasLationamerica
                          .qTwoArtistasLatinPageOne),
                  const Text(
                    StringsArtistasLationamerica.qThreeArtistasLatinPageOne,
                    style: ThemeText.paragraph16GrayBold,
                  ),
                  const CustomRecordAudioButton(
                      question: StringsArtistasLationamerica
                          .qThreeArtistasLatinPageOne),
                  Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 175,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ThemeColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            final audioProvider =
                                Provider.of<RecordAudioProvider>(context,
                                    listen: false);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 24,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                backgroundColor: ThemeColors.white,
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: ThemeColors.yellow,
                                ),
                                title: const Text(
                                  '¡Atención!',
                                  style: ThemeText.h3title22Red,
                                ),
                                content: const Text(
                                  '¿Seguro que quieres eliminar todos los audios?',
                                  style: ThemeText.paragraph16GrayNormal,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                      style: ThemeText.paragraph16BlueBold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      audioProvider.clearAllData();
                                      setState(() {
                                        audioProvider.recordsDeleted;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Si',
                                      style: ThemeText.paragraph16RedBold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (loading)
                                ? [
                                    const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]
                                : [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Cancelar",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: 175,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ThemeColors.yellow),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Resposta enviada com sucesso!"),
                              duration: Duration(seconds: 2),
                            ));
                            Navigator.pushNamed(context,
                                '/pUno_artistas_latinoamericanos_tarea_dos');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (loading)
                                ? [
                                    const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]
                                : [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Listo",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
