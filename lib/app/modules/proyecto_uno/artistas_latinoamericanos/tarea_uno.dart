import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings_artistas_latinoamericanos.dart';
import 'package:proyectemos/commons/google_sign_in.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/record_audio_provider.dart';
import '../../../../utils/email_sender.dart';
import '../../../proyectemos_repository.dart';
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
  final formKey = GlobalKey<FormState>();

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
    // final currentUser = getCurrentUser(context);
    final audioProvider =
        Provider.of<RecordAudioProvider>(context, listen: false);
    bool isAudioFinish = audioProvider.isRecording;
    final recordsPathList = RecordAudioProvider.recordingsPaths;

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
                      StringsArtistasLationamerica
                          .titleQOnePageOneArtistasLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      StringsArtistasLationamerica.qOneArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question:
                          StringsArtistasLationamerica.qOneArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
                    ),
                    const Text(
                      StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question:
                          StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
                    ),
                    const Text(
                      StringsArtistasLationamerica.qThreeArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question: StringsArtistasLationamerica
                          .qThreeArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
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
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();

                          if (recordsPathList.isEmpty ||
                              recordsPathList.length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!")));
                          } else {
                            if (recordsPathList.isNotEmpty &&
                                recordsPathList.length == 3) {
                              sendAnswers(provider.googleSignIn.currentUser);
                              sendEmail(context, recordsPathList);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Resposta enviada com sucesso!"),
                                duration: Duration(seconds: 2),
                              ));
                              Navigator.pushNamed(context,
                                  '/pUno_artistas_latinoamericanos_tarea_dos');
                            }
                          }
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
                    // ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // GoogleSignInAccount? getCurrentUser(BuildContext context) {
  //   final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  //   var currentUser = provider.googleSignIn.currentUser;

  //   if (currentUser == null) {
  //     provider.googleSignIn.signInSilently();
  //     provider.googleLogin();
  //     currentUser = provider.googleSignIn.currentUser;
  //   } else if (currentUser.authentication == null) {
  //     provider.googleLogout();
  //     provider.googleSignIn.signInSilently();
  //     provider.googleLogin();
  //   }
  //   return currentUser;
  // }

  Future convertAudioToFirebase(audioPaths, currentUser) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = await currentUser.email;

    var counter = 0;

    try {
      for (var audio in audioPaths) {
        if (audioPaths == null) return;
        var file = File(audio);
        counter++;

        var snapshot = await firebaseStorage
            .ref()
            .child(
                'uno-artistas-latinoamericanos-audios/$email-audio-$counter.mp3')
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert audio: ${e.toString()}';
    }
  }

  Future<dynamic> makeJson(currentUser) async {
    var list = RecordAudioProvider.recordingsPaths;
    var firebasePaths = await convertAudioToFirebase(list, currentUser);
    var json = setJson(firebasePaths);
    return json;
  }

  setJson(audioList) {
    final json = {
      'resposta_1': audioList[0],
      'resposta_2': audioList[1],
      'resposta_3': audioList[2],
    };
    return json;
  }

  sendAnswers(currentUser) async {
    var json = await makeJson(currentUser);
    String doc = 'uno/artistas-latinoamericanos/atividade_1/';

    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<void> sendEmail(currentUser, recordsPathList) async {
    var firstAudio = File(recordsPathList[0]);
    var secondAudio = File(recordsPathList[1]);
    var thirdAudio = File(recordsPathList[2]);

    final attachment = [
      FileAttachment(firstAudio,
          contentType: 'audio/mp3', fileName: 'Primeiro Audio'),
      FileAttachment(secondAudio,
          contentType: 'audio/mp3', fileName: 'Segundo Audio'),
      FileAttachment(thirdAudio,
          contentType: 'audio/mp3', fileName: 'Terceiro Audio')
    ];

    const email = [
      'comesana.alexis.silvera@gmail.com',
      'fernandamaiadeoliveira@gmail.com'
    ];
    const subject = "Atividade Artistas Latinoamericanos";
    const text =
        "Atividade Artistas Latinoamericanos 1ª etapa concluída!\nObs: Arquivo mp4.";
    final emailSender = EmailSender();

    emailSender.sendEmailToTeacher(
        currentUser, attachment, email, subject, text);
  }
}
