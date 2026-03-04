import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/strings/strings.dart';
import '../../../repository/repository_impl.dart';
import '../../../services/toast_services.dart';

class TeacherController {
  final BuildContext context;

  TeacherController(this.context);

  final _repository = RepositoryImpl();

  Future<void> sendEmail(
    GoogleSignInAccount? currentUser,
    String subject,
    String description,
  ) async {
    final studentInfo = await _repository.getStudentInfo();
    final message = createEmailMessage(subject, description, studentInfo);

    currentUser ??= await _repository.getSignedInUser();
    if (currentUser == null) {
      throw Exception('Usuário não autenticado');
    }

    await _repository.sendEmail(
      currentUser: currentUser,
      answerList: [],
      subject: subject,
      body: message,
      attachments: [],
    );

    showToast(
      context,
      Strings.emailEnviado,
      ThemeColors.green,
      ThemeColors.white,
    );
  }

  // Future<void> sendEmail(
  //   GoogleSignInAccount currentUser,
  //   String subject,
  //   String description,
  // ) async {
  //   final message = createEmailMessage(
  //     subject,
  //     description,
  //     await _repository.getStudentInfo(),
  //   );
  //
  //   await _repository.sendEmail(currentUser, [], subject, message, []);
  //   showToast(
  //     context,
  //     Strings.emailEnviado,
  //     ThemeColors.green,
  //     ThemeColors.white,
  //   );
  // }

  String createEmailMessage(
    String subject,
    String description,
    List<String> allStudentInfo,
  ) {
    final text =
        '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n
$subject\n\n
$description''';
    return text;
  }
}
