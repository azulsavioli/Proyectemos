import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/commons/strings/strings_conoces_podcast.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../providers/record_audio_provider_conoces_podcast_impl.dart';
import '../../../../../services/toast_services.dart';

class ConocesPodcastController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Conoces el Podcast';
  final doc = 'dos/conoces-podcast/atividade_1/';
  final task = 'conocesPodcastCompleted';

  bool isAudioFinish = RecordAudioConocesPodcastProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioConocesPodcastProviderImpl.recordingsPaths;

  String answer1 = '';
  String answer2 = '';

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
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
      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
    recordsPathList.clear();
  }

  List<String> makeAnswerList() {
    return [answer1, answer2];
  }

  Future<dynamic> makeJson(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioConocesPodcastProviderImpl.recordingsPaths;
    final firebasePaths = await convertAudioToFirebase(list, currentUser);
    final json = setJson(firebasePaths);
    return json;
  }

  Map<String, dynamic> setJson(List<dynamic> audioList) {
    final json = {
      'resposta_1': answer1,
      'resposta_2': answer2,
      'resposta_3': audioList[0],
      'resposta_4': audioList[1],
    };
    return json;
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
              'dos-conoces-podcast-audios/$email-audio-$counter.mp3',
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

  List<FileAttachment> createAudioAttachments(
    List<String> recordsPathList,
  ) {
    final firstAudio = File(recordsPathList[0]);
    final secondAudio = File(recordsPathList[1]);

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
Respostas:\n
${StringsConocesPodcast.questionOneConocesPodcast}: $answer1\n
${StringsConocesPodcast.questionDosConocesPodcast}: $answer2\n 
${StringsConocesPodcast.questionTresConocesPodcast}: Resposta no primeiro audio\n 
${StringsConocesPodcast.questionQuatroConocesPodcast}: Resposta no segundo audio\n 
Atividade Conoces un Podcast concluída!\nObs: Arquivo mp3.''';
    return text;
  }
}
