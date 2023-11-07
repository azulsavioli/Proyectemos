import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../providers/record_audio_provider_la_encuesta_tarea_dos.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class TareaDosComoCrearUnaEncuestaController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Como crear una encuesta';
  final doc = 'dos/la-encuesta/atividade_2/';
  final task = 'laEncuestaTareaDosCompleted';

  bool isAudioFinish = RecordAudioLaEncuestaTareaDosProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioLaEncuestaTareaDosProviderImpl.recordingsPaths;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
    try {
      final json = await makeJson(currentUser);
      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createAudioAttachments(recordsPathList);

      await _repository.sendEmail(
        currentUser,
        [],
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
  }

  Future<dynamic> makeJson(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioLaEncuestaTareaDosProviderImpl.recordingsPaths;
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
              'dos-la-encuesta-audios_tarea_dos/$email-audio-$counter.mp3',
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
${StringsLaEncuesta.questionOneLaEncuestaTareaDos}:  Resposta no primeiro audio\n
${StringsLaEncuesta.questionTwoLaEncuestaTareaDos}:  Resposta no segundo audio\n \n 
${StringsLaEncuesta.questionThreeLaEncuestaTareaDos}:  Resposta no terceiro audio\n \n 

Atividade Que es una encuesta concluída!''';
    return text;
  }
}
