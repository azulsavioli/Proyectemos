import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class TareaDosGrabacionPodcastController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade 2 - Grabación del Poscast - Grabar el podcast';
  final doc = 'dos/grabacion-podcast/atividade_2/';
  final task = 'grabacionPodcastTareaDosCompleted';
  List studentGroup = [];
  List<PlatformFile> files = [];

  PlatformFile? pickedFile;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> poscastInfos,
  ) async {
    try {
      final json = await makeJson(poscastInfos, currentUser);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        poscastInfos,
      );

      await _repository.sendEmail(
        currentUser,
        poscastInfos,
        subject,
        message,
        [],
      );
      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveClassroomPodcast(json);
      await _repository.saveTaskCompleted(task);
      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
    studentGroup = [];
  }

  Future selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return;

    pickedFile = fileSelected.files.first;
    files.add(pickedFile!);
    notifyListeners();
    return pickedFile;
  }

  Future makeJson(List<String> poscastInfos, currentUser) async {
    final path = await makeFirebasePaths(currentUser);
    final json = {
      'grupo': '$studentGroup',
      'nome_podcast': poscastInfos[0],
      'nome_episodio_podcast': poscastInfos[1],
      'podcast_link': poscastInfos[2],
      'logo_podcast': path[0],
    };
    return json;
  }

  Future<dynamic> makeFirebasePaths(currentUser) async {
    final listFile = setFiles();
    final firebasePathFile = await convertFileToFirebase(
      listFile,
      currentUser,
    );
    return firebasePathFile;
  }

  List<FileAttachment> createAttachments() {
    final filePathList = setFiles();
    final firstArchive = File(filePathList[0]);

    final attachment = [
      FileAttachment(
        firstArchive,
        fileName: 'Logo podcast',
      ),
    ];

    return attachment;
  }

  Future convertFileToFirebase(filePaths, currentUser) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = currentUser?.email;

    var counter = 0;

    try {
      for (final item in filePaths) {
        if (filePaths == null) return;
        final file = File(item);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child('dos-logo-podcast-arquivos/$email-img-$counter.jpeg')
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

  List setFiles() {
    final filePaths = [];
    for (final item in files) {
      filePaths.add(item.path);
    }
    notifyListeners();
    return filePaths;
  }

  List<String> makeAnswersList(
    List<String> listAnswers,
  ) {
    final respostas = [
      listAnswers[0],
      listAnswers[1],
      listAnswers[2],
    ];
    return respostas;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    List<String> respostas,
  ) {
    var studentsNames = '';

    if (studentGroup.length == 2) {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}''';
    } else {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}
Aluno 3: ${studentGroup[2]}''';
    }

    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n
Atividade 2 - Grabación del Poscast - Grabar el podcast, tarefa concluída!\n
$studentsNames\n 
Link podcast:
${StringsLaEncuesta.questionOneLaEncuestaTareaDos}: ${respostas[0]}\n
''';
    return text;
  }
}
