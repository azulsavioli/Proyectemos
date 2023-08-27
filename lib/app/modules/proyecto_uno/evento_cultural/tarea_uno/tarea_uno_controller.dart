import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings.dart';
import '../../../../../services/toast_services.dart';

class EventoCulturalTareaUnoController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Criação de Evento\n Tarea Uno';
  final doc = 'uno/criacao_evento/atividade_1/';
  final task = 'eventoTareaUnoCompleted';
  List<String> studentInformations = [];

  List<PlatformFile> files = [];

  final audioProvider = RecordAudioProviderEventoCulturalImpl();
  bool isAudioFinish = RecordAudioProviderEventoCulturalImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioProviderEventoCulturalImpl.recordingsPaths;
  PlatformFile? pickedFile;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
  ) async {
    try {
      final json = await makeFirebasePaths(currentUser);
      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createAttachments(currentUser, recordsPathList);

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
    recordsPathList = [];
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

  Map<String, List> setJson(filePath, audioPath) {
    final json = {
      'resposta_1_file': [filePath[0]],
      'resposta_2_audio': [audioPath[0]]
    };
    return json;
  }

  Future<dynamic> makeFirebasePaths(currentUser) async {
    final listFile = setFiles();
    final firebasePathFile = await convertFileToFirebase(
      listFile,
      currentUser,
    );
    final listAudio = RecordAudioProviderEventoCulturalImpl.recordingsPaths;
    final firebasePathAudio =
        await convertAudioToFirebase(listAudio, currentUser);
    final path = setJson(firebasePathFile, firebasePathAudio);
    return path;
  }

  List<FileAttachment> createAttachments(
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) {
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
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Criação de Evento concluída!\nObs: Arquivos diversos.''';
    return text;
  }
}
