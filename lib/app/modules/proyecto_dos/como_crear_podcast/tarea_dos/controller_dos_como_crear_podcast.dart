import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings.dart';

import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class ControllerCrearUnPodcast extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject =
      'Atividade - Cómo crear un Podcast - Crear un Podcast\n Tarea Dos';
  final doc = 'dos/como_crear_un_podcast/atividade_2/';
  final task = 'comoCrearPodcastTareaDosCompleted';
  final studentGroup = [];

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> answersList,
  ) async {
    try {
      final json = _repository.createJson(
        answersList,
      );

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answersList,
      );

      await _repository.sendEmail(
        currentUser,
        answersList,
        subject,
        message,
        [],
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

  List<String> makeAnswersList(
    String textOne,
    String textTwo,
    String textThree,
    String textFour,
    String textFive,
    String textSix,
  ) {
    final respostas = [
      textOne,
      textTwo,
      textThree,
      textFour,
      textFive,
      textSix,
    ];
    return respostas;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    List<String> respostas,
  ) {
    var studentsNames = '';

    if (studentGroup.length == 2) {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}''';
    } else {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}
Aluno 3: ${studentGroup[2]}''';
    }

    final text = '''
Proyectemos
Aluno: ${allStudentInfo[0]}
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}
Atividade Cómo crear un podcast 2ª tarefa concluída!\n
$studentsNames\n
Resposta: ${respostas[0]}
Resposta: ${respostas[1]}
Resposta: ${respostas[2]}
Resposta: ${respostas[3]}
Resposta: ${respostas[4]}
Resposta: ${respostas[5]}
''';
    return text;
  }
}
