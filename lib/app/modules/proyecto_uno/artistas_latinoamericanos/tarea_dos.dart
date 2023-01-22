import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_artistas_latinoamericanos.dart';
import '../../../../commons/styles.dart';
import '../../widgets/custom_upload_form.dart';
import '../../widgets/drawer_menu.dart';

class PUnoArtistasLatinoamericanosTareaDosPage extends StatefulWidget {
  const PUnoArtistasLatinoamericanosTareaDosPage({super.key});

  @override
  State<PUnoArtistasLatinoamericanosTareaDosPage> createState() =>
      _PUnoArtistasLatinoamericanosTareaDosPageState();
}

class _PUnoArtistasLatinoamericanosTareaDosPageState
    extends State<PUnoArtistasLatinoamericanosTareaDosPage> {
  @override
  initState() {
    super.initState();
    generateCountrysList();
  }

  final formKey = GlobalKey<FormState>();

  final answerUnoController = TextEditingController();
  final answerDosController = TextEditingController();

  // var randonCountrys = [];

  bool loading = false;

  // generateCountrysList() {
  //   const listCountrys = [
  //     'Argentina',
  //     'Bolívia',
  //     'Chile',
  //     'Colômbia',
  //     'Costa Rica',
  //     'Cuba',
  //     'República Dominicana',
  //     'Equador',
  //     'El Salvador',
  //     'Guatemala',
  //     'Honduras',
  //     'México',
  //     'Nicarágua',
  //     'Panamá',
  //     'Paraguai',
  //     'Peru',
  //     'Porto Rico',
  //     'Espanha',
  //     'Uruguai',
  //     'Venezuela'
  //   ];

  //   if (randonCountrys.isNotEmpty) {
  //     randonCountrys = [];
  //   }

  //   for (var i = 0; i < 5; i++) {
  //     int randomNumber = Random().nextInt(20) + 1;

  //     randonCountrys.add(listCountrys[randomNumber]);
  //   }
  // }

  var randonCountrys = [];

  generateCountrysList() {
    const listCountrys = [
      'Argentina',
      'Bolívia',
      'Chile',
      'Colômbia',
      'Costa Rica',
      'Cuba',
      'República Dominicana',
      'Equador',
      'El Salvador',
      'Guatemala',
      'Honduras',
      'México',
      'Nicarágua',
      'Panamá',
      'Paraguai',
      'Peru',
      'Porto Rico',
      'Espanha',
      'Uruguai',
      'Venezuela'
    ];

    while (randonCountrys.length < 5) {
      int randomNumber = Random().nextInt(20);
      String country = listCountrys[randomNumber];
      if (!randonCountrys.contains(country)) {
        randonCountrys.add(country);
      }
    }
  }

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
        child: Form(
          key: formKey,
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
                    const Text(
                      textAlign: TextAlign.center,
                      StringsArtistasLationamerica
                          .titleQOnePageDosArtistasLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < randonCountrys.length; i++)
                            CustomUploadForm(
                              title: randonCountrys[i],
                              controller: TextEditingController(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.yellow),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          final json = {
                            'resposta_1': answerUnoController.text,
                            'resposta_2': answerDosController.text,
                          };
                          // sendAnswersToFirebase(json);
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
                                      "¡Compartir!",
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
          ),
        ),
      ),
    );
  }
}
