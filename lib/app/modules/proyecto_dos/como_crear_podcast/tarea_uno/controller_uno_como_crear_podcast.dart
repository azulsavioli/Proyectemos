import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings.dart';

import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class ControllerEscucharPodcast extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject =
      'Atividade - Cómo crear un Podcast - Escuchar Podcast\n Tarea Uno';
  final doc = 'dos/como_crear_un_podcast/atividade_1/';
  final task = 'comoCrearPodcastTareaUnoCompleted';

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
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Cómo crear un podcast 1ª tarefa concluída!
\n
Paso 1:
Resposta: ${respostas[0]}
\n
Paso 2: 
Resposta: ${respostas[1]}
\n
Paso 3: 
Resposta: ${respostas[2]}
\n
Paso 4: 
Resposta: ${respostas[3]}
\n
Paso 5: 
Resposta: ${respostas[4]}
\n
Paso 6: 
Resposta: ${respostas[5]}

''';
    return text;
  }
}
