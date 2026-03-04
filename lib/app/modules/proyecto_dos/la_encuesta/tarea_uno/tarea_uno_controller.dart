import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/repository/repository_impl.dart';
import 'package:mailer/mailer.dart';

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
  String answer3 = '';

  Future<void> sendAnswersText(
    BuildContext context,
    GoogleSignInAccount? currentUser,
    String answer3,
  ) async {
    await _repository.isTaskLoading(task, true);
    try {
      final answerList = makeAnswerListText(answer1, answer2, answer3);

      final json = _repository.createJson(answerList);

      final message = createEmailMessageTextAnswer(
        await _repository.getStudentInfo(),
        answerList,
      );

      await _repository.sendEmail(
        currentUser: currentUser,
        answerList: answerList,
        subject: subject,
        body: message,
        attachments: [],
      );
      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.isTaskLoading(task, false);

      showToast(
        context,
        Strings.tareaEnviada,
        ThemeColors.green,
        ThemeColors.white,
      );
      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast(
        context,
        'Ocurrio un erro no envio dos datos!',
        ThemeColors.red,
        ThemeColors.white,
      );
    }
  }

  Future<void> sendAnswersAudio(
    BuildContext context,
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
    await _repository.isTaskLoading(task, true);

    try {
      final json = await makeJsonAudio(currentUser);
      final answerList = makeAnswerList(answer1, answer2);
      final message = createEmailMessage(await _repository.getStudentInfo());

      final attachment = createAudioAttachments(recordsPathList);

      await _repository.sendEmail(
        currentUser: currentUser,
        answerList: answerList,
        subject: subject,
        body: message,
        attachments: attachment,
      );

      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.isTaskLoading(task, false);

      showToast(
        context,
        Strings.tareaEnviada,
        ThemeColors.green,
        ThemeColors.white,
      );

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast(
        context,
        'Ocurrio un erro no envio dos datos!',
        ThemeColors.red,
        ThemeColors.white,
      );
    }
  }

  Future<dynamic> makeJsonAudio(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioLaEncuestaTareaUnoProviderImpl.recordingsPaths;
    final firebasePaths = await convertAudioToFirebase(list, currentUser);
    final json = setJsonAudio(firebasePaths);
    return json;
  }

  Map<String, dynamic> setJsonAudio(List<dynamic> audioList) {
    final json = {
      'resposta_1': answer1,
      'resposta_2': answer2,
      'resposta_3': audioList[0],
    };
    return json;
  }

  List<String> makeAnswerList(answer1, answer2) {
    return [answer1, answer2];
  }

  List<String> makeAnswerListText(answer1, answer2, answer3) {
    return [answer1, answer2, answer3];
  }

  List<FileAttachment> createAudioAttachments(List<String> recordsPathList) {
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
            .child('dos-la-encuesta-audios_tarea_uno/$email-audio-$counter.mp3')
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

  String createEmailMessage(List<String> allStudentInfo) {
    final text =
        '''
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

  String createEmailMessageTextAnswer(
    List<String> allStudentInfo,
    List<String> answersList,
  ) {
    final text =
        '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Respostas:\n
${StringsLaEncuesta.questionOneLaEncuestaTareaUno}: $answer1\n
${StringsLaEncuesta.questionTwoLaEncuestaTareaUno}: $answer2\n 
${StringsLaEncuesta.questionThreeLaEncuestaTareaUno}: $answer3\n 

Atividade Que es una encuesta concluída!''';
    return text;
  }
}
