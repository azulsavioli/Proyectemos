import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_evento_cultural.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/proyectemos_repository.dart';
import '../../../../services/toast_services.dart';
import '../../../../utils/email_sender.dart';
import '../../../../utils/get_user.dart';
import '../../widgets/custom_record_audio_button.dart';
import '../../widgets/drawer_menu.dart';

class CriacaoEventoPage extends StatefulWidget {
  const CriacaoEventoPage({super.key});

  static List<PlatformFile> file = [];

  @override
  State<CriacaoEventoPage> createState() => _CriacaoEventoPageState();
}

class _CriacaoEventoPageState extends State<CriacaoEventoPage> {
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
    final repository = context.read<ProyectemosRepository>();
    final currentUser = getCurrentUser(context);

    final audioProvider = Provider.of<RecordAudioProviderEventoCulturalImpl>(
      context,
      listen: false,
    );
    final isAudioFinish = audioProvider.isRecording;
    var recordsPathList = RecordAudioProviderEventoCulturalImpl.recordingsPaths;
    if (recordsPathList.length > 1) {
      recordsPathList = [];
    }

    PlatformFile? pickedFile;
    var _isFileButtonDisabled = false;

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

    final listFiles = CriacaoEventoPage.file;

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
      final listAudio = RecordAudioProviderEventoCulturalImpl.recordingsPaths;
      final firebasePathAudio = await convertAudioToFirebase(listAudio);
      final path = setJson(firebasePathFile, firebasePathAudio);
      return path;
    }

    Future sendAnswers() async {
      final json = await makeFirebasePaths();
      const doc = 'uno/criacao_evento/atividade_1/';

      try {
        return repository.saveAnswers(doc, json);
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

      final email = await getEmailTeacherFromFirebase();

      final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
      final studentInformation = studentInfo.split('/');

      final allStudentInfo = [
        studentInformation[3],
        studentInformation[0],
        studentInformation[1],
        studentInformation[2]
      ];

      const subject = 'Atividade - Criação do Evento';
      final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
Atividade Criação de Evento 1ª etapa concluída!''';
      final emailSender = EmailSender();

      await emailSender.sendEmailToTeacher(
        currentUser,
        attachment,
        [email.first.values.first],
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
        title: Text(
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
              Text(
                textAlign: TextAlign.start,
                StringsEventoCultural.descriptionOneEventocultural,
                style: ThemeText.paragraph16GrayNormal,
              ),
              SizedBox(
                height: 350,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
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
              Text(
                textAlign: TextAlign.start,
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
                    selectFile(CriacaoEventoPage.file);
                    setState(
                      () {
                        if (pickedFile == null) {
                          _isFileButtonDisabled = false;
                        } else {
                          _isFileButtonDisabled = true;
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
                    if (recordsPathList.isEmpty) {
                      showToast(
                        '''¡No se puede enviar la respuesta! Graba los audios y haz clic en guardar!''',
                        color: ThemeColors.red,
                        textColor: ThemeColors.white,
                      );
                    } else {
                      if (recordsPathList.isNotEmpty &&
                          recordsPathList.length == 1) {
                        sendAnswers();
                        sendEmail(currentUser, recordsPathList);
                        saveEventoCulturalTareaUnoCompleted();
                        showToast(Strings.tareaConcluida);
                        recordsPathList = [];
                        Navigator.pushNamed(
                          context,
                          '/pUno_evento_cultural_menu',
                        );
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

  Future<void> saveEventoCulturalTareaUnoCompleted() async {
    const eventoTareaUnoCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      'eventoTareaUnoCompleted',
      eventoTareaUnoCompleted,
    );
  }
}
