import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../repository/proyectemos_repository.dart';
import '../../../utils/email_sender.dart';

class TeacherController {
  final BuildContext context;

  TeacherController(this.context);
  final _repository = ProyectemosRepository();

  Future<List> getEmailTeacherFromFirebase() async {
    final emails = [];
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getTeacherEmail();
      emails.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return emails;
  }

  Future<void> sendEmail(
    GoogleSignInAccount currentUser,
    String subject,
    String description,
  ) async {
    final email = await getEmailTeacherFromFirebase();
    final studentInfo = await _repository.getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]}\n\n 
$description''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      [],
      [email.first.values.first],
      subject,
      text,
    );
  }
}
