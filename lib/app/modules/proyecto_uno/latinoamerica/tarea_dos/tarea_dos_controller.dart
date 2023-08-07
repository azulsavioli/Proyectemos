import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';
import '../../../widgets/step.dart';

class TareaDosController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Latinoamerica\n Tarea Dos';
  final doc = 'uno/latinoamerica/atividade_2/';

  List<String> studentInformations = [];
  List<XFile> selectedImages = CustomStep.images;

  Future<void> saveTaskCompleted() async {
    const task = 'latinoamericaTareaDosCompleted';
    await _repository.saveTaskCompleted(task);
  }

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
      await _repository.saveClassroomImages(json);
      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
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
    };
    return json;
  }

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
  ) {
    final respostas = [
      textOne,
      textTwo,
      textThree,
      textFour,
      textFive,
    ];
    return respostas;
  }
}
