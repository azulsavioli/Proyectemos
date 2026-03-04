import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_latinoamerica.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class LatinoamericaTareaUnoController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade - Latinoamerica\n Tarea Uno';
  final doc = 'uno/latinoamerica/atividade_1/';
  final task = 'latinoamericaTareaUnoCompleted';

  Future<void> sendAnswers(
    context,
    GoogleSignInAccount? currentUser,
    List<String> answersList,
  ) async {
    await _repository.isTaskLoading(task, true);
    try {
      final json = _repository.createJson(answersList);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answersList,
      );

      await _repository.sendEmail(
        currentUser: currentUser,
        answerList: answersList,
        subject: subject,
        body: message,
        attachments: [],
      );
      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.isTaskLoading(task, false);

      showToast(
        context,
        Strings.tareaEnviada,
        ThemeColors.green,
        ThemeColors.white,
      );
      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast(
        context,
        'Ocurrio un erro no envio dos datos!',
        ThemeColors.red,
        ThemeColors.white,
      );
    }
  }

  List<String> makeAnswersList(
    String textOne,
    String textTwo,
    String textThree,
    String textFour,
    String textFive,
  ) {
    final respostas = [textOne, textTwo, textThree, textFour, textFive];
    return respostas;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
    List<String> respostas,
  ) {
    final text =
        '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Latinoamerica 1ª tarefa concluída!
\n\n
Pergunta: ${StringsLationamerica.qOneLatin}
Resposta: ${respostas[0]}
\n\n
Pergunta: ${StringsLationamerica.qTwoLatinTwo}
Resposta: ${respostas[1]}
\n\n
Pergunta: ${StringsLationamerica.qThreeLatin}
Resposta: ${respostas[2]}
\n\n
Pergunta: ${StringsLationamerica.qFourLatin}
Resposta: ${respostas[3]}
\n\n
Pergunta: ${StringsLationamerica.qFiveLatin}
Resposta: ${respostas[4]}
''';
    return text;
  }
}
