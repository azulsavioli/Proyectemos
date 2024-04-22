import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class CreacionDeSuMovimentoTareaDosController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade 2 - La red social del movimento';
  final doc = 'tres/crea-tu-movimiento/atividade_2/';
  final task = 'creaTuMovimientoTareaDosCompleted';
  List studentGroup = [];
  List<PlatformFile> files = [];
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
      'movimiento_link': movimientoInfo[1],
    };
    return json;
  }

  List<String> makeAnswersList(
    List<String> listAnswers,
  ) {
    final respostas = [
      listAnswers[0],
      listAnswers[1],
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
Atividade 2 - La red social del movimento, tarefa concluída!\n
$studentsNames\n 
Nome do movimento: ${respostas[0]}\n
Link do movimento: ${respostas[1]}\n
''';
    return text;
  }
}
