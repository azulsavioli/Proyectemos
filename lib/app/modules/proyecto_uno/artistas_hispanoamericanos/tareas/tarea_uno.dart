import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings_artistas_latinoamericanos.dart';
import 'package:proyectemos/utils/get_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commons/strings.dart';
import '../../../../../commons/styles.dart';
import '../../../../../providers/record_audio_provider_latinoamerica_impl.dart';
import '../../../../../utils/email_sender.dart';
import '../../../../proyectemos_repository.dart';
import '../../../widgets/custom_carousel.dart';
import '../../../widgets/custom_record_audio_button.dart';
import '../../../widgets/drawer_menu.dart';

class PUnoArtistasLatinoamericanosTareaUnoPage extends StatefulWidget {
  const PUnoArtistasLatinoamericanosTareaUnoPage({super.key});

  @override
  State<PUnoArtistasLatinoamericanosTareaUnoPage> createState() =>
      _PUnoArtistasLatinoamericanosTareaUnoPageState();
}

class _PUnoArtistasLatinoamericanosTareaUnoPageState
    extends State<PUnoArtistasLatinoamericanosTareaUnoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loadingImages();
    super.initState();
  }

  final imgList = [
    'https://citaliarestauro.com/wp-content/uploads/2021/07/Imagem1.jpg',
    'https://cdn.culturagenial.com/imagens/coluna-partida-cke.gif',
    'https://cdn.culturagenial.com/imagens/o-veado-ferido-cke.jpg',
    'https://fridakahlo.site/wp-content/uploads/2022/02/1945-completa-hope2.jpg'
  ];

  final imgNameList = [
    'Autorretrato con collar de espinas, 1940',
    'La columna rota, 1944',
    'El venado herido, 1946',
    'Desesperado, 1945'
  ];

  bool loading = true;
  bool recordsDeleted = false;

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<RecordAudioProviderLatinoamericaImpl>(
      context,
      listen: false,
    );
    final isAudioFinish = audioProvider.isRecording;
    var recordsPathList = RecordAudioProviderLatinoamericaImpl.recordingsPaths;

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
                    Center(
                      child: Text(
                        'Frida Kahlo',
                        style: ThemeText.h2title35BlueNormal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (loading)
                      const SizedBox(
                        height: 400,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors.yellow,
                          ),
                        ),
                      )
                    else
                      CustomCarousel(
                        imgList: imgList,
                        imgNameList: imgNameList,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      StringsArtistasLationamerica
                          .titleQOnePageOneArtistasLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      StringsArtistasLationamerica.qOneArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question:
                          StringsArtistasLationamerica.qOneArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
                      namedRoute: '/record_and_play',
                      labelButton: 'Grabar la respuesta',
                      labelButtonFinished: 'Completo',
                    ),
                    Text(
                      StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question:
                          StringsArtistasLationamerica.qTwoArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
                      namedRoute: '/record_and_play',
                      labelButton: 'Grabar la respuesta',
                      labelButtonFinished: 'Completo',
                    ),
                    Text(
                      StringsArtistasLationamerica.qThreeArtistasLatinPageOne,
                      style: ThemeText.paragraph16GrayBold,
                    ),
                    CustomRecordAudioButton(
                      question: StringsArtistasLationamerica
                          .qThreeArtistasLatinPageOne,
                      isAudioFinish: isAudioFinish,
                      namedRoute: '/record_and_play',
                      labelButton: 'Grabar la respuesta',
                      labelButtonFinished: 'Completo',
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
                          final currentUser = getCurrentUser(context);

                          if (recordsPathList.isEmpty ||
                              recordsPathList.length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  '''
¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!
''',
                                ),
                              ),
                            );
                          } else {
                            if (recordsPathList.isNotEmpty &&
                                recordsPathList.length == 3) {
                              sendAnswers(currentUser, recordsPathList);
                              saveArtistasTareaUnoCompleted();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Resposta enviada com sucesso!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              recordsPathList = [];

                              Navigator.pushNamed(
                                context,
                                '/pUno_artistas_menu',
                              );
                            }
                          }
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
                                      'Listo',
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

  Future convertAudioToFirebase(
    List<String> audioPaths,
    GoogleSignInAccount? currentUser,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = currentUser?.email;

    var counter = 0;

    try {
      for (final audio in audioPaths) {
        if (audioPaths.isEmpty) return;
        final file = File(audio);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child(
              'uno-artistas-latinoamericanos-audios/$email-audio-$counter.mp3',
            )
            .putFile(file)
            .whenComplete(() => null);

        final downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert audio: ${e.message}';
    }
  }

  Future<dynamic> makeJson(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioProviderLatinoamericaImpl.recordingsPaths;
    final firebasePaths = await convertAudioToFirebase(list, currentUser);
    final json = setJson(firebasePaths);
    return json;
  }

  Map<String, dynamic> setJson(List<dynamic> audioList) {
    final json = {
      'resposta_1': audioList[0],
      'resposta_2': audioList[1],
      'resposta_3': audioList[2],
    };
    return json;
  }

  Future sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
    final json = await makeJson(currentUser);
    const doc = 'uno/artistas-latinoamericanos/atividade_1/';

    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
      await Future.delayed(
        const Duration(seconds: 20),
        () => sendEmail(recordsPathList, currentUser),
      );
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> getEmailTeacherFromFirebase() async {
    final emails = [];
    const doc = 'professora';
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getTeacherEmail(doc);
      emails.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return emails;
  }

  Future<void> sendEmail(
    List<String> recordsPathList,
    GoogleSignInAccount? currentUser,
  ) async {
    final firstAudio = File(recordsPathList[0]);
    final secondAudio = File(recordsPathList[1]);
    final thirdAudio = File(recordsPathList[2]);

    final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    final attachment = [
      FileAttachment(
        firstAudio,
        contentType: 'audio/mp3',
        fileName: 'Primeiro Audio',
      ),
      FileAttachment(
        secondAudio,
        contentType: 'audio/mp3',
        fileName: 'Segundo Audio',
      ),
      FileAttachment(
        thirdAudio,
        contentType: 'audio/mp3',
        fileName: 'Terceiro Audio',
      )
    ];

    final email = await getEmailTeacherFromFirebase();

    const subject = 'Atividade - Artistas Latinoamericanos 1';
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
Atividade Artistas Latinoamericanos 1ª etapa concluída!\nObs: Arquivo mp4.''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      attachment,
      [email.first.values.first],
      subject,
      text,
    );
  }

  Future<void> saveArtistasTareaUnoCompleted() async {
    const artistasTareaUnoCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      'artistasTareaUnoCompleted',
      artistasTareaUnoCompleted,
    );
  }

  Future loadingImages() async {
    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        loading = false;
      });
    });
  }
}
