import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../services/toast_services.dart';

class GrabacionPodcastController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade 1 - Grabación del Poscast - Guión de grabación';
  final doc = 'dos/grabacion-podcast/atividade_1/';
  final task = 'grabacionPodcastTareaUnoCompleted';
  final studentGroup = [];

  List<String> studentInformations = [];

  List<PlatformFile> files = [];

  PlatformFile? pickedFile;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
  ) async {
    await _repository.isTaskLoading(task, true);

    try {
      final json = await makeFirebasePaths(currentUser);
      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createAttachments();

      await _repository.sendEmail(
        currentUser,
        [],
        subject,
        message,
        attachment,
      );

      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.isTaskLoading(task, false);

      showToast(Strings.tareaEnviada);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
    files = [];
  }

  Future selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return;

    pickedFile = fileSelected.files.first;
    files.add(pickedFile!);
    notifyListeners();
    return pickedFile;
  }

  Map<String, List> setJson(filePath) {
    final json = {
      'resposta_1_file': [filePath[0]],
    };
    return json;
  }

  Future<dynamic> makeFirebasePaths(currentUser) async {
    final listFile = setFiles();
    final firebasePathFile = await convertFileToFirebase(
      listFile,
      currentUser,
    );
    final path = setJson(firebasePathFile);
    return path;
  }

  List<FileAttachment> createAttachments() {
    final filePathList = setFiles();
    final firstArchive = File(filePathList[0]);

    final attachment = [
      FileAttachment(
        firstArchive,
        fileName: 'Guión de grabación',
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
            .child(
                'dos-guion-de-grabacion-podcast-arquivos/$email-img-$counter.jpeg')
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

  String createEmailMessage(
    List<String> allStudentInfo,
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
Proyectemos - Dos
Aluno: ${allStudentInfo[0]}
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}
Atividade 1 - Grabación del Poscast - Guión de grabación, tarefa concluída!\n
$studentsNames\n
\nObs: Arquivos diversos
''';
    return text;
  }
}
