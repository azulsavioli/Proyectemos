import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings_crea_tu_movimiento.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class CreacionDeSuMovimentoTareaUnoController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade 1 - Nuestro movimiento social';
  final doc = 'tres/crea-tu-movimiento/atividade_1/';
  final task = 'creaTuMovimientoTareaUnoCompleted';
  List studentGroup = [];

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
    List<String> movimientoInfo,
  ) async {
    try {
      final json = await makeJson(movimientoInfo, currentUser);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        movimientoInfo,
      );

      await _repository.sendEmail(
        currentUser,
        movimientoInfo,
        subject,
        message,
        [],
      );
      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveClassroomMovimientoSociale(json);
      await _repository.saveTaskCompleted(task);
      showToast(Strings.tareaConcluida);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
    studentGroup = [];
  }

  Future makeJson(List<String> movimientoInfo, currentUser) async {
    final json = {
      'grupo': '$studentGroup',
      'nome_del_movimiento': movimientoInfo[0],
      'causa_del_movimiento': movimientoInfo[1],
      'porque_elegido_el_movimiento': movimientoInfo[2],
      'movilizaciones': movimientoInfo[3],
      'red_social': movimientoInfo[4],
    };
    return json;
  }

  List<String> makeAnswersList(
    List<String> listAnswers,
  ) {
    final respostas = [
      listAnswers[0],
      listAnswers[1],
      listAnswers[2],
      listAnswers[3],
      listAnswers[4],
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
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n
Atividade  1 - Nuestro movimiento social, tarefa concluída!\n
$studentsNames\n 
${StringsCreaTuMovimiento.preguntaUno}
Resposta 1: ${respostas[0]}\n
${StringsCreaTuMovimiento.preguntaDos}
Resposta 2: ${respostas[1]}\n
${StringsCreaTuMovimiento.preguntaTres}
Resposta 3: ${respostas[2]}\n
${StringsCreaTuMovimiento.preguntaCuatro}
Resposta 4: ${respostas[3]}\n
${StringsCreaTuMovimiento.preguntaCinco}
Resposta 5: ${respostas[4]}\n
''';
    return text;
  }
}
