import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_evento_cultural.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/record_audio_provider.dart';
import '../../../../utils/email_sender.dart';
import '../../../../utils/get_user.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/custom_record_audio_button.dart';
import '../../widgets/drawer_menu.dart';

class CriacaoEventoDescricaoPage extends StatefulWidget {
  const CriacaoEventoDescricaoPage({super.key});

  static List<PlatformFile> file = [];

  @override
  State<CriacaoEventoDescricaoPage> createState() =>
      _CriacaoEventoDescricaoPageState();
}

class _CriacaoEventoDescricaoPageState
    extends State<CriacaoEventoDescricaoPage> {
  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;

  bool buttonAudioSelected = false;
  Icon buttonAudioIcon = const Icon(Icons.record_voice_over);
  Color buttonAudioColor = ThemeColors.yellow;

  bool loading = false;
  bool recordsDeleted = false;

  void customizeStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  void initState() {
    customizeStatusAndNavigationBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider =
        Provider.of<RecordAudioProvider>(context, listen: false);
    final isAudioFinish = audioProvider.isRecording;
    var recordsPathList = RecordAudioProvider.recordingsPaths;
    if (recordsPathList.length > 1) {
      recordsPathList = [];
    }

    PlatformFile? pickedFile;
    var isFileButtonDisabled = false;
    var isAudioButtonDisabled = false;
    const propuestaEvento = '''
${StringsEventoCultural.descriptionOneEventocultural}
        ° Elegir un artista\n
        ° Elegir el tipo de evento\n
        ° Elegir el sítio\n
        ° Nombre del evento\n
        ° El público destinatario\n
        ° Objetivo del evento\n
        ${StringsEventoCultural.descriptionTwoEventocultural}''';

    Future selectFile(List<PlatformFile> file) async {
      final fileSelected = await FilePicker.platform.pickFiles();
      if (fileSelected == null) return;

      setState(
        () {
          pickedFile = fileSelected.files.first;
          buttonFileColor = ThemeColors.green;
          buttonFileIcon = const Icon(Icons.check);
          buttonFileSelected = true;
        },
      );

      file.add(pickedFile!);
      return pickedFile;
    }

    Future convertFileToFirebase(filePaths) async {
      final firebaseStorage = FirebaseStorage.instance;
      final firebasePaths = [];
      final user = getCurrentUser(context);
      final email = user?.email;

      var counter = 0;

      try {
        for (final item in filePaths) {
          if (filePaths == null) return;
          final file = File(item);
          counter++;

          final snapshot = await firebaseStorage
              .ref()
              .child('uno-criacao-evento-arquivos/$email-img-$counter.jpeg')
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

    Future convertAudioToFirebase(audioPaths) async {
      final firebaseStorage = FirebaseStorage.instance;
      final firebasePaths = [];
      final user = getCurrentUser(context);
      final email = user?.email;

      var counter = 0;

      try {
        for (final audio in audioPaths) {
          if (audioPaths == null) return;
          final file = File(audio);
          counter++;

          final snapshot = await firebaseStorage
              .ref()
              .child('uno-criacao-evento-audios/$email-audio-$counter.mp3')
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

    final listFiles = CriacaoEventoDescricaoPage.file;

    List setFiles() {
      final filePaths = [];
      for (final file in listFiles) {
        filePaths.add(file.path);
      }
      return filePaths;
    }

    Map<String, List> setJson(filePath, audioPath) {
      final json = {
        'resposta_1_file': [filePath[0]],
        'resposta_2_audio': [audioPath[0]]
      };
      return json;
    }

    Future<dynamic> makeFirebasePaths() async {
      final listFile = setFiles();
      final firebasePathFile = await convertFileToFirebase(listFile);
      final listAudio = RecordAudioProvider.recordingsPaths;
      final firebasePathAudio = await convertAudioToFirebase(listAudio);
      final path = setJson(firebasePathFile, firebasePathAudio);
      return path;
    }

    Future sendAnswers() async {
      final json = await makeFirebasePaths();
      const doc = 'uno/criacao_evento/atividade_1/';

      try {
        return await context
            .read<ProyectemosRepository>()
            .saveAnswers(doc, json);
      } on FirebaseException catch (e) {
        return e.toString();
      }
    }

    Future<void> sendEmail(currentUser, recordsPathList) async {
      final filePathList = setFiles();
      final firstArchive = File(filePathList[0]);
      final firstAudio = File(recordsPathList[0]);

      final attachment = [
        FileAttachment(
          firstArchive,
          fileName: 'Proposta Escrita',
        ),
        FileAttachment(
          firstAudio,
          contentType: 'audio/mp3',
          fileName: 'Proposta Audio',
        ),
      ];

      const email = [
        'comesana.alexis.silvera@gmail.com',
        'fernandamaiadeoliveira@gmail.com'
      ];

      const subject = 'Atividade 1 - Criação do Evento';
      const text = 'Atividade Criação de Evento 1ª etapa concluída!';
      final emailSender = EmailSender();

      await emailSender.sendEmailToTeacher(
        currentUser,
        attachment,
        email,
        subject,
        text,
      );
    }

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
          Strings.titleEventoCulturalUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                StringsEventoCultural.descriptionOneEventocultural,
                style: ThemeText.paragraph16GrayNormal,
              ),
              SizedBox(
                height: 350,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 30),
                  children: const [
                    ListTile(title: Text('° Elegir un artista;')),
                    ListTile(title: Text('° Elegir el tipo de evento;')),
                    ListTile(title: Text('° Elegir el sítio;')),
                    ListTile(title: Text('° Nombre del evento;')),
                    ListTile(title: Text('° El público destinatario;')),
                    ListTile(title: Text('° Objetivo del evento;')),
                  ],
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                StringsEventoCultural.descriptionTwoEventocultural,
                style: ThemeText.paragraph16GrayNormal,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  icon: buttonFileIcon,
                  onPressed: () {
                    selectFile(CriacaoEventoDescricaoPage.file);
                    setState(
                      () {
                        if (pickedFile == null) {
                          isFileButtonDisabled = false;
                        } else {
                          isFileButtonDisabled = true;
                        }
                      },
                    );
                  },
                  label: const Text(
                    'Subir la propuesta escrita',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomRecordAudioButton(
                question: propuestaEvento,
                isAudioFinish: isAudioFinish,
                namedRoute: '/record_and_play_propuesta',
                labelButton: 'Subir la propuesta oral',
                labelButtonFinished: 'Propuesta salva',
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final currentUser = getCurrentUser(context);

                    if (recordsPathList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '''¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!''',
                          ),
                        ),
                      );
                    } else {
                      if (recordsPathList.isNotEmpty &&
                          recordsPathList.length == 1) {
                        sendAnswers();
                        sendEmail(currentUser, recordsPathList);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Resposta enviada com sucesso!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        recordsPathList = [];
                        Navigator.pushNamed(context, '/pUno_evento_cultural');
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '¡Compartir!',
                          style:
                              TextStyle(fontSize: 20, color: ThemeColors.white),
                        ),
                      ),
                    ],
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
