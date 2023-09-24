import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class TareaDosComoCrearUnaEncuestaController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Como crear una encuesta';
  final doc = 'dos/la-encuesta/atividade_2/';
  final task = 'laEncuestaTareaDosCompleted';

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
  ) {
    final respostas = [
      textOne,
      textTwo,
      textThree,
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
Respostas:\n
${StringsLaEncuesta.questionOneLaEncuestaTareaDos}: ${respostas[0]}\n
${StringsLaEncuesta.questionTwoLaEncuestaTareaDos}: ${respostas[1]}\n 
${StringsLaEncuesta.questionThreeLaEncuestaTareaDos}: ${respostas[2]}\n 

Atividade Que es una encuesta concluída!''';
    return text;
  }
}
