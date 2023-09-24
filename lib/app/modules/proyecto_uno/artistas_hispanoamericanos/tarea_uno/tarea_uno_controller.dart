import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../providers/record_audio_provider_artistas_impl.dart';
import '../../../../../services/toast_services.dart';

class ArtistasLatinoamericanosTareaUnoController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  bool loading = true;
  final subject = 'Atividade - Artistas Latinoamericanos\n Tarea Uno';
  final doc = 'uno/artistas-latinoamericanos/atividade_1/';
  final task = 'artistasTareaUnoCompleted';

  bool isAudioFinish = RecordAudioArtistasProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioArtistasProviderImpl.recordingsPaths;

  Future loadingImages() async {
    await Future.delayed(const Duration(seconds: 5), () {
      loading = false;
    });
  }

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> answersList,
  ) async {
    try {
      final json = await makeJson(currentUser);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createAudioAttachments(recordsPathList);

      await _repository.sendEmail(
        currentUser,
        answersList,
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
    recordsPathList = [];
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
    final list = RecordAudioArtistasProviderImpl.recordingsPaths;
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

  List<FileAttachment> createAudioAttachments(
    List<String> recordsPathList,
  ) {
    final firstAudio = File(recordsPathList[0]);
    final secondAudio = File(recordsPathList[1]);
    final thirdAudio = File(recordsPathList[2]);

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
Atividade Artistas Latinoamericanos 1ª etapa concluída!\nObs: Arquivo mp3.''';
    return text;
  }
}
