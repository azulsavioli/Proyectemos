import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_artistas_latinoamericanos.dart';
import '../../../../commons/styles.dart';
import '../../../../utils/email_sender.dart';
import '../../../../utils/get_user.dart';
import '../../../proyectemos_repository.dart';
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
  void initState() {
    super.initState();
    generateCountrysList();
  }

  final formKey = GlobalKey<FormState>();

  final answerUnoController = TextEditingController();
  final answerDosController = TextEditingController();
  final answerTresController = TextEditingController();
  final answerQuatroController = TextEditingController();
  final answerCincoController = TextEditingController();

  bool loading = false;

  List randonCountrys = [];

  void generateCountrysList() {
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
      final randomNumber = Random().nextInt(20);
      final country = listCountrys[randomNumber];
      if (!randonCountrys.contains(country)) {
        randonCountrys.add(country);
      }
    }
  }

  Future convertFileToFirebase(List<String> filePaths) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final user = getCurrentUser(context);
    final email = user?.email;

    var counter = 0;

    try {
      for (final item in filePaths) {
        if (filePaths.isEmpty) return;
        final file = File(item);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child(
              'uno-artistas-latinoamericanos-arquivos/$email-img-$counter.jpeg',
            )
            .putFile(file)
            .whenComplete(() => null);

        final downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert image: ${e.message}';
    }
  }

  List<PlatformFile> listFiles = CustomUploadForm.listFiles;

  List<String> setFiles() {
    final filePaths = <String>[];
    for (final file in listFiles) {
      filePaths.add(file.path!);
    }
    return filePaths;
  }

  Map<String, List> setJson(List<dynamic> filePaths) {
    final json = {
      'resposta_1': [answerUnoController.text, filePaths[0]],
      'resposta_2': [answerDosController.text, filePaths[1]],
      'resposta_3': [answerTresController.text, filePaths[2]],
      'resposta_4': [answerQuatroController.text, filePaths[3]],
      'resposta_5': [answerCincoController.text, filePaths[4]],
    };
    return json;
  }

  Future<dynamic> makeJson() async {
    final list = setFiles();
    final firebasePaths = await convertFileToFirebase(list);
    final json = setJson(firebasePaths);
    return json;
  }

  Future<dynamic> sendAnswers() async {
    final json = await makeJson();
    const doc = 'uno/artistas-latinoamericanos/atividade_2/';

    try {
      return await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<void> sendEmail(GoogleSignInAccount? currentUser) async {
    final filePathList = setFiles();
    final firstArchive = File(filePathList[0]);
    final secondArchive = File(filePathList[1]);
    final thirdArchive = File(filePathList[2]);
    final fourthArchive = File(filePathList[3]);
    final fifthArchive = File(filePathList[4]);

    final attachment = [
      FileAttachment(firstArchive, fileName: 'Artista_${randonCountrys[0]}'),
      FileAttachment(secondArchive, fileName: 'Artista_${randonCountrys[1]}'),
      FileAttachment(thirdArchive, fileName: 'Artista_${randonCountrys[2]}'),
      FileAttachment(fourthArchive, fileName: 'Artista_${randonCountrys[3]}'),
      FileAttachment(fifthArchive, fileName: 'Artista_${randonCountrys[4]}'),
    ];

    const email = [
      'comesana.alexis.silvera@gmail.com',
      'fernandamaiadeoliveira@gmail.com'
    ];

    const subject = 'Atividade 2 - Artistas Latinoamericanos';
    final text = '''
        Atividade Artistas Latinoamericanos 2ª etapa concluída!
        \nPaís: ${randonCountrys[0]} - Artista: ${answerUnoController.text}
        \nPaís: ${randonCountrys[1]} - Artista: ${answerDosController.text}
        \nPaís: ${randonCountrys[2]} - Artista: ${answerTresController.text}
        \nPaís: ${randonCountrys[3]} - Artista: ${answerQuatroController.text}
        \nPaís: ${randonCountrys[4]} - Artista: ${answerCincoController.text}
        \nObs: Arquivos diversos.''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      attachment,
      email,
      subject,
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

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
        title: const Text(
          Strings.titleArtistasHispanoamericanosUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                          CustomUploadForm(
                            title: randonCountrys[0],
                            controller: answerUnoController,
                          ),
                          CustomUploadForm(
                            title: randonCountrys[1],
                            controller: answerDosController,
                          ),
                          CustomUploadForm(
                            title: randonCountrys[2],
                            controller: answerTresController,
                          ),
                          CustomUploadForm(
                            title: randonCountrys[3],
                            controller: answerQuatroController,
                          ),
                          CustomUploadForm(
                            title: randonCountrys[4],
                            controller: answerCincoController,
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
                          sendAnswers();
                          sendEmail(currentUser);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Resposta enviada com sucesso!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pushNamed(context, '/proyecto_uno');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: loading
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
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      '¡Compartir!',
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
