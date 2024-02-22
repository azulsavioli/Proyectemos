import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';
import '../../../widgets/custom_upload_form.dart';

class ArtistasLatinoamericanosTareaDosController extends ChangeNotifier {
  final _repository = RepositoryImpl();

  final doc = 'uno/artistas-latinoamericanos/atividade_2/';
  final subject = 'Atividade - Artistas Hispanoamericanos\n Tarea Dos';
  final task = 'artistasTareaDosCompleted';

  List<PlatformFile> listFiles = CustomUploadForm.listFiles;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<TextEditingController> answersList,
  ) async {
    try {
      final json = await makeJson(answersList);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answersList,
      );

      final attachment = setupAttachments();

      await _repository.sendEmail(
        currentUser,
        answersList,
        subject,
        message,
        attachment,
      );
      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveClassroomImages(json);
      await _repository.saveTaskCompleted(task);

      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
  }

  bool loading = false;

  List randonCountrys = [];

  void generateCountrysList() {
    const listCountrys = [
      'Argentina',
      'Bolivia',
      'Chile',
      'Colômbia',
      'Costa Rica',
      'Cuba',
      'República Dominicana',
      'Equador',
      'El Salvador',
      'Guatemala',
      'Honduras',
      'México',
      'Nicaragua',
      'Panamá',
      'Paraguay',
      'Peru',
      'Porto Rico',
      'España',
      'Uruguay',
      'Venezuela',
    ];

    while (randonCountrys.length < 5) {
      final randomNumber = Random().nextInt(20);
      final country = listCountrys[randomNumber];
      if (!randonCountrys.contains(country)) {
        randonCountrys.add(country);
      }
    }
  }

  Future convertFileToFirebase(
    List<String> filePaths,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = _repository.authService.userAuth?.email;

    var counter = 0;

    try {
      for (final item in filePaths) {
        if (filePaths.isEmpty) return;
        final file = File(item);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child(
              'uno-artistas-hispanoamericanos-arquivos/$email-img-$counter.jpeg',
            )
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

  List<String> setFiles() {
    final filePaths = <String>[];
    for (final file in listFiles) {
      filePaths.add(file.path!);
    }
    return filePaths;
  }

  Map<String, List> setJson(
    List<dynamic> filePaths,
    List<TextEditingController> answerList,
  ) {
    final json = {
      'resposta_1': [answerList[0].text, filePaths[0]],
      'resposta_2': [answerList[1].text, filePaths[1]],
      'resposta_3': [answerList[2].text, filePaths[2]],
      'resposta_4': [answerList[3].text, filePaths[3]],
      'resposta_5': [answerList[4].text, filePaths[4]],
    };
    return json;
  }

  Future<dynamic> makeJson(
    List<TextEditingController> answerList,
  ) async {
    final list = setFiles();
    final firebasePaths = await convertFileToFirebase(list);
    final json = setJson(firebasePaths, answerList);
    return json;
  }

  List<FileAttachment> setupAttachments() {
    final filePathList = setFiles();
    final firstArchive = File(filePathList[0]);
    final secondArchive = File(filePathList[1]);
    final thirdArchive = File(filePathList[2]);
    final fourthArchive = File(filePathList[3]);
    final fifthArchive = File(filePathList[4]);

    final attachment = [
      FileAttachment(firstArchive, fileName: 'Artista_${randonCountrys[0]}'),
      FileAttachment(secondArchive, fileName: 'Artista_${randonCountrys[1]}'),
      FileAttachment(thirdArchive, fileName: 'Artista_${randonCountrys[2]}'),
      FileAttachment(fourthArchive, fileName: 'Artista_${randonCountrys[3]}'),
      FileAttachment(fifthArchive, fileName: 'Artista_${randonCountrys[4]}'),
    ];
    return attachment;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    List<TextEditingController> answerList,
  ) {
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]}\n\n 
        Atividade Artistas Hispanoamericanos 2ª etapa concluída!
        \nPaís: ${randonCountrys[0]} - Artista: ${answerList[0].text}
        \nPaís: ${randonCountrys[1]} - Artista: ${answerList[1].text}
        \nPaís: ${randonCountrys[2]} - Artista: ${answerList[2].text}
        \nPaís: ${randonCountrys[3]} - Artista: ${answerList[3].text}
        \nPaís: ${randonCountrys[4]} - Artista: ${answerList[4].text}
        \nObs: Arquivos diversos.''';
    return text;
  }
}
