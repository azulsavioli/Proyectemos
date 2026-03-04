import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/repository_impl.dart';
import '../../../services/toast_services.dart';

class RegistrationController extends ChangeNotifier {
  final _repository = RepositoryImpl();

  Future<void> setStudentOptions(
    String schoolInfo,
    String classRoomInfo,
    String studentName,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final studentSchoolInfo = schoolInfo;
    final studentClassRoomInfo = classRoomInfo;
    final studentNameInfo = studentName;
    await preferences.setString('studentSchoolInfo', studentSchoolInfo);
    await preferences.setString('studentClassRoomInfo', studentClassRoomInfo);
    await preferences.setString('studentName', studentNameInfo);
    await preferences.setBool('studentInfoSaved', true);
  }

  void saveStudentOptions(
    GoogleSignInAccount? currentUser,
    String studentSchoolInfo,
    String studentClassRoomInfo,
    String studentNameInfo,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      setStudentOptions(
        studentSchoolInfo,
        studentClassRoomInfo,
        studentNameInfo,
      ).then(
        (value) => saveStudentInfo(context, currentUser, studentNameInfo).then(
          (value) => showToast(
            context,
            'Datos salvos com sucesso',
            ThemeColors.green,
            ThemeColors.white,
          ),
        ),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showToast(
        context,
        '''¡Ups! Ha ocurrido un error y sus datos no ha sido enviado. ¡Inténtalo de nuevo!''',
        ThemeColors.yellow,
        ThemeColors.white,
      );
    }
  }

  Future<void> saveStudentInfo(
    BuildContext context,
    GoogleSignInAccount? currentUser,
    String studentNameInfo,
  ) async {
    try {
      if (currentUser == null) return;
      final json = {'nome_aluno_${currentUser.id}': studentNameInfo};
      await _repository.saveClassroomStudents(json);
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
}
