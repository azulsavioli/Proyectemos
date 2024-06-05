import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../providers/record_audio_provider_la_encuesta_tarea_uno.dart';
import '../../../../../services/toast_services.dart';

class QueEsUnaEncuestaController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Que es una encuesta';
  final doc = 'dos/la-encuesta/atividade_1/';
  final task = 'laEncuestaTareaUnoCompleted';

  bool isAudioFinish = RecordAudioLaEncuestaTareaUnoProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioLaEncuestaTareaUnoProviderImpl.recordingsPaths;

  String answer1 = '';
  String answer2 = '';

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
    await _repository.isTaskLoading(task, true);

    try {
      final json = await makeJson(currentUser);
      final answerList = makeAnswerList();
      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createAudioAttachments(recordsPathList);

      await _repository.sendEmail(
        currentUser,
        answerList,
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
  }

  Future<dynamic> makeJson(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioLaEncuestaTareaUnoProviderImpl.recordingsPaths;
    final firebasePaths = await convertAudioToFirebase(list, currentUser);
    final json = setJson(firebasePaths);
    return json;
  }

  Map<String, dynamic> setJson(List<dynamic> audioList) {
    final json = {
      'resposta_1': answer1,
      'resposta_2': answer2,
      'resposta_3': audioList[0],
    };
    return json;
  }

  List<String> makeAnswerList() {
    return [answer1, answer2];
  }

  List<FileAttachment> createAudioAttachments(
    List<String> recordsPathList,
  ) {
    final firstAudio = File(recordsPathList[0]);

    final attachment = [
      FileAttachment(
        firstAudio,
        contentType: 'audio/mp3',
        fileName: 'Primeiro Audio',
      ),
    ];
    return attachment;
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
              'dos-la-encuesta-audios_tarea_uno/$email-audio-$counter.mp3',
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

  String createEmailMessage(
    List<String> allStudentInfo,
  ) {
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Respostas:\n
${StringsLaEncuesta.questionOneLaEncuestaTareaUno}: $answer1\n
${StringsLaEncuesta.questionTwoLaEncuestaTareaUno}: $answer2\n 
${StringsLaEncuesta.questionThreeLaEncuestaTareaUno}:  Resposta no primeiro audio\n 

Atividade Que es una encuesta concluída!''';
    return text;
  }
}
