import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../repository/repository_impl.dart';

class TeacherController {
  final BuildContext context;

  TeacherController(this.context);
  final _repository = RepositoryImpl();

  Future<void> sendEmail(
    GoogleSignInAccount currentUser,
    String subject,
    String description,
  ) async {
    final message = createEmailMessage(
      subject,
      description,
      await _repository.getStudentInfo(),
    );

    await _repository.sendEmail(
      currentUser,
      [],
      subject,
      message,
      [],
    );
  }

  String createEmailMessage(
    String subject,
    String description,
    List<String> allStudentInfo,
  ) {
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
$subject\n\n
$description''';
    return text;
  }
}
