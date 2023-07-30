import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/toast_services.dart';

class RegistrationController {
  Future<void> setStudentOptions(
    String schoolInfo,
    String classRoomInfo,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final studentSchoolInfo = schoolInfo;
    final studentClassRoomInfo = classRoomInfo;
    await preferences.setString('studentSchoolInfo', studentSchoolInfo);
    await preferences.setString('studentClassRoomInfo', studentClassRoomInfo);
    await preferences.setBool('studentInfoSaved', true);
  }

  void saveStudentOptions(
    String studentSchoolInfo,
    String studentClassRoomInfo,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      setStudentOptions(
        studentSchoolInfo,
        studentClassRoomInfo,
      ).then(
        (value) => showToast('Datos salvos com sucesso'),
      );
      Navigator.pushNamed(context, '/proyectos');
    } else {
      showToast(
        '''¡Ups! Ha ocurrido un error y sus datos no ha sido enviado. ¡Inténtalo de nuevo!''',
      );
    }
  }
}
