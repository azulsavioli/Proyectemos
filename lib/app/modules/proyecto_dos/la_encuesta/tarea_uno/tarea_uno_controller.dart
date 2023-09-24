import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../services/toast_services.dart';

class QueEsUnaEncuestaController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Que es una encuesta';
  final doc = 'dos/la-encuesta/atividade_1/';
  final task = 'laEncuestaTareaUnoCompleted';

  String answer1 = '';
  String answer2 = '';

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    String answer3,
  ) async {
    try {
      final json = setJson(answer3);
      final answerList = makeAnswerList(answer3);
      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answer3,
      );

      await _repository.sendEmail(
        currentUser,
        answerList,
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

  List<String> makeAnswerList(String answer3) {
    return [answer1, answer2, answer3];
  }

  Map<String, dynamic> setJson(String answer3) {
    final json = {
      'resposta_1': answer1,
      'resposta_2': answer2,
      'resposta_3': answer3,
    };
    return json;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    String answer3,
  ) {
    final text = '''
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
