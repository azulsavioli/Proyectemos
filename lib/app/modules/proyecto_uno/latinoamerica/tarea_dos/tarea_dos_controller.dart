import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';
import '../../../widgets/step.dart';

class TareaDosController {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Latinoamerica\n Tarea Dos';
  final doc = 'uno/latinoamerica/atividade_2/';
  final task = 'latinoamericaTareaDosCompleted';
  List<String> studentInformations = [];
  List<XFile> selectedImages = CustomStep.images;

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> answersList,
  ) async {
    try {
      final json = await makeJsonImages(answersList);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answersList,
      );

      final attachment = setupAttachments(answersList);

      await _repository.sendEmail(
        currentUser,
        answersList,
        subject,
        message,
        attachment,
      );
      await _repository.sendAnswersToFirebase(json, doc);
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
    await _repository.saveTaskCompleted(task);

    showToast(Strings.tareaConcluida);
  }

  List<FileAttachment> setupAttachments(
    List<String> answersList,
  ) {
    final imagesList = setImages();
    final fileOne = File(imagesList[0]);
    final fileTwo = File(imagesList[1]);
    final fileThree = File(imagesList[2]);
    final fileFour = File(imagesList[3]);
    final fileFive = File(imagesList[4]);
    final fileSix = File(imagesList[5]);
    final fileSeven = File(imagesList[6]);
    final fileEight = File(imagesList[7]);
    final fileNine = File(imagesList[8]);
    final fileTen = File(imagesList[9]);

    final attachment = [
      FileAttachment(
        fileOne,
        fileName: 'Descrição Imagem 1: ${answersList[0]}',
      ),
      FileAttachment(
        fileTwo,
        fileName: 'Descrição Imagem 2: ${answersList[1]}',
      ),
      FileAttachment(
        fileThree,
        fileName: 'Descrição Imagem 3: ${answersList[2]}',
      ),
      FileAttachment(
        fileFour,
        fileName: 'Descrição Imagem 4: ${answersList[3]}',
      ),
      FileAttachment(
        fileFive,
        fileName: 'Descrição Imagem 5: ${answersList[4]}',
      ),
      FileAttachment(
        fileSix,
        fileName: 'Descrição Imagem 6: ${answersList[5]}',
      ),
      FileAttachment(
        fileSeven,
        fileName: 'Descrição Imagem 7: ${answersList[6]}',
      ),
      FileAttachment(
        fileEight,
        fileName: 'Descrição Imagem 8: ${answersList[7]}',
      ),
      FileAttachment(
        fileNine,
        fileName: 'Descrição Imagem 9: ${answersList[8]}',
      ),
      FileAttachment(
        fileTen,
        fileName: 'Descrição Imagem 10: ${answersList[9]}',
      ),
    ];
    return attachment;
  }

  List<String> setImages() {
    final imgPaths = <String>[];

    for (final img in selectedImages) {
      imgPaths.add(img.path);
    }
    return imgPaths;
  }

  Future convertImageToFirebase(
    List<String> imgPaths,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = _repository.authService.userAuth?.email;

    var counter = 0;

    try {
      for (final img in imgPaths) {
        if (imgPaths.isEmpty) return;
        final file = File(img);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child('uno-latinoamerica-images/$email-img-$counter.jpeg')
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

  Map<String, Object> createJson(
    List<String> answersList,
    List<dynamic> imagesList,
  ) {
    final json = {
      'resposta_1': [answersList[0], imagesList[0]],
      'resposta_2': [answersList[1], imagesList[1]],
      'resposta_3': [answersList[2], imagesList[2]],
      'resposta_4': [answersList[3], imagesList[3]],
      'resposta_5': [answersList[4], imagesList[4]],
      'resposta_6': [answersList[5], imagesList[5]],
      'resposta_7': [answersList[6], imagesList[6]],
      'resposta_8': [answersList[7], imagesList[7]],
      'resposta_9': [answersList[8], imagesList[8]],
      'resposta_10': [answersList[9], imagesList[9]],
    };
    return json;
  }

  Map<String, Object> createJsonForFirebase(
    List<String> answersList,
    List<dynamic> imagesList,
  ) {
    final json = {
      'nome': '${_repository.authService.userAuth?.displayName}',
      'imagem_latinoamerica_1': [answersList[0], imagesList[0]],
      'imagem_latinoamerica_2': [answersList[1], imagesList[1]],
      'imagem_latinoamerica_3': [answersList[2], imagesList[2]],
      'imagem_latinoamerica_4': [answersList[3], imagesList[3]],
      'imagem_latinoamerica_5': [answersList[4], imagesList[4]],
      'imagem_latinoamerica_6': [answersList[5], imagesList[5]],
      'imagem_latinoamerica_7': [answersList[6], imagesList[6]],
      'imagem_latinoamerica_8': [answersList[7], imagesList[7]],
      'imagem_latinoamerica_9': [answersList[8], imagesList[8]],
      'imagem_latinoamerica_10': [answersList[9], imagesList[9]]
    };
    return json;
  }

  // Future makeJson(List<String> answersList) async {
  //   final list = setImages();
  //   final imagesList = await convertImageToFirebase(list);
  //   final json = createJson(answersList, imagesList);
  //   return json;
  // }

  Future makeJsonImages(List<String> answersList) async {
    final list = setImages();
    final imagesList = await convertImageToFirebase(list);
    final json = createJsonForFirebase(answersList, imagesList);
    return json;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    List<String> respostas,
  ) {
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Latinoamerica 2ª tarefa concluída!
\n
Descrição Imagem 1: ${respostas[0]}
Descrição Imagem 2: ${respostas[1]}
Descrição Imagem 3: ${respostas[2]}
Descrição Imagem 4: ${respostas[3]}
Descrição Imagem 5: ${respostas[4]} 
Descrição Imagem 6: ${respostas[5]}
Descrição Imagem 7: ${respostas[6]}
Descrição Imagem 8: ${respostas[7]}
Descrição Imagem 9: ${respostas[8]}
Descrição Imagem 10: ${respostas[9]}
\n
Imagens em anexo!
''';
    return text;
  }

  List<String> makeAnswersList(
    String textOne,
    String textTwo,
    String textThree,
    String textFour,
    String textFive,
    String textSix,
    String textSeven,
    String textEight,
    String textNine,
    String textTen,
  ) {
    final respostas = [
      textOne,
      textTwo,
      textThree,
      textFour,
      textFive,
      textSix,
      textSeven,
      textEight,
      textNine,
      textTen,
    ];
    return respostas;
  }
}
