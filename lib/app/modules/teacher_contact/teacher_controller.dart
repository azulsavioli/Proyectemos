import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../repository/repository_impl.dart';
import '../../../utils/email_sender.dart';

class TeacherController {
  final BuildContext context;

  TeacherController(this.context);
  final _repository = RepositoryImpl();

  Future<void> sendEmail(
    GoogleSignInAccount currentUser,
    String subject,
    String description,
  ) async {
//    final email = await getEmailTeacherFromFirebase();
//    final studentInfo = await _repository.getUserInfo();
//    final studentInformation = studentInfo.split('/');

//    final allStudentInfo = [
//      studentInformation[0],
//      studentInformation[1],
//      studentInformation[2]
//    ];

    final emailSender = EmailSender();

//    await emailSender.sendEmailToTeacher(
//      currentUser,
    //    [],
//      [email.first.values.first],
    //  subject,
    //    text,
//    );
//  }

    String createEmailMessage(
      List<String> allStudentInfo,
      List<String> respostas,
    ) {
      final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]}\n\n 
$description''';

      return text;
    }
  }
}
