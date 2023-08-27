import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/repository/repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commons/strings.dart';
import '../../../../../services/toast_services.dart';
import 'question_one_divulgacao.dart';

class DivulgacaoController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  bool loading = true;
  final subject = 'Atividade - Divulgacao - Video do Evento Cultural';
  final doc = 'uno/artistas-latinoamericanos/atividade_1/';
  final task = 'divulgationCompleted';

  OpcoesCompartilhamento? sendingType = OpcoesCompartilhamento.todos;

  PlatformFile? pickedFile;

  Future selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return;
    pickedFile = fileSelected.files.first;

    return pickedFile;
  }

  Future makeJson(currentUser) async {
    final firebasePaths = await convertVideoToFirebase();

    final json = {
      'aluno': currentUser?.displayName,
      'resposta_1': firebasePaths[0],
    };
    return json;
  }

  Future convertVideoToFirebase() async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final videoPaths = pickedFile?.path;

    final email = _repository.authService.userAuth?.email;

    try {
      if (videoPaths == null || videoPaths == '') return;
      final file = File(videoPaths);

      final snapshot = await firebaseStorage
          .ref()
          .child(
            'uno-video-divulgacao/$email-video.mp4',
          )
          .putFile(file)
          .whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      firebasePaths.add(downloadUrl);

      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert video: ${e.message}';
    }
  }

  List<String?> setFiles() {
    final filePaths = <String?>[];
    if (pickedFile != null) {
      filePaths.add(pickedFile?.path);
    }
    return filePaths;
  }

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
  ) async {
    try {
      final json = await makeJson(currentUser);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createVideoAttachments();

      await _repository.sendEmail(
        currentUser,
        [],
        subject,
        message,
        attachment,
      );

      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);

      if (sendingType == OpcoesCompartilhamento.todos) {
        await _repository.savePublicVideo(json);
      } else {
        await _repository.saveClassroomVideo(json);
      }
      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
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

  List<FileAttachment> createVideoAttachments() {
    final filePathList = setFiles();

    final firstArchive = File(filePathList[0]!);

    final attachment = [
      FileAttachment(firstArchive, fileName: 'Video_evento_cultural'),
    ];

    return attachment;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
  ) {
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Divulgação concluída!\nObs: Arquivo mp4.''';
    return text;
  }

  Future<void> saveDivulgationFeedType(OpcoesCompartilhamento? feedType) async {
    var feedTurma = false;
    var feedAll = false;
    if (feedType == OpcoesCompartilhamento.turma) {
      feedTurma = true;
    } else {
      feedAll = true;
    }
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('feedTurma', feedTurma);
    await preferences.setBool('feedTodos', feedAll);
  }

  Future<void> saveDivulgationCompleted() async {
    const divulgationCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('divulgationCompleted', divulgationCompleted);
  }
}
