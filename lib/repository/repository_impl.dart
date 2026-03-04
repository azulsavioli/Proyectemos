import 'dart:math';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/repository/repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/proyectemos_repository.dart';
import '../services/auth_services.dart';
import '../utils/email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class RepositoryImpl<T> extends Repository<T, dynamic, dynamic> {
  List<String> student = [];
  List<String> studentInformations = [];
  late SharedPreferences sharedPreferences;
  String studentSchoolInfo = '';
  String studentClassRoomInfo = '';

  final _repository = ProyectemosRepository();
  final emailSender = EmailSender();
  AuthService authService = AuthService();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<GoogleSignInAccount?> getSignedInUser() async {
    try {
      final account = await _googleSignIn.attemptLightweightAuthentication();
      return account;
    } catch (e) {
      print('Erro ao obter usuário logado: $e');
      return null;
    }
  }

  Future<List<String>> getTeacherEmails() async {
    try {
      final emails = await _repository.getTeacherEmail();
      return emails;
    } catch (e) {
      print('Erro ao obter e-mails dos professores: $e');
      return [];
    }
  }

  @override
  Map<T, T> createJson(List answersList) {
    final jsonList = [];
    for (var i = 0; i < answersList.length; i++) {
      jsonList.add({'resposta_$i': answersList[i]});
    }
    return {for (final e in jsonList) e.keys.first: e.values.first};
  }

  @override
  Future<void> isTaskLoading(T taskName, bool bool) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isLoadingTask-$taskName", bool);
  }

  @override
  Future<void> saveTaskCompleted(T taskName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(taskName.toString(), true);
  }

  Future<void> resetTaskCompleted(T taskName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(taskName.toString(), false);
  }

  @override
  Future<void> sendAnswersToFirebase(Map<T, T> json, T doc) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveAnswers(doc.toString(), convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomImagesLatinoamerica(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveImagesTurmaLatinoamerica(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomImagesArtistas(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveImagesTurmaArtistas(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomPodcast(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.savePodcastTurma(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomMovimientoSociale(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveMovimientoSocialeTurma(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomStudents(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveClassroomStudents(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomVideo(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveVideosTurma(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> saveClassroomMovimientosSocialesVideo(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveVideosMovimientosSocialesTurma(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  @override
  Future<void> savePublicVideo(Map<T, T> json) async {
    final convertedJson = _convertMapToStringDynamic(json);
    try {
      await _repository.saveVideosPublic(convertedJson);
    } on FirebaseException catch (e) {
      e.toString();
    }
  }

  Map<String, dynamic> _convertMapToStringDynamic(Map<T, T> inputMap) {
    final convertedMap = <String, dynamic>{};
    inputMap.forEach((key, value) {
      convertedMap[key.toString()] = value;
    });
    return convertedMap;
  }

  @override
  Future<void> sendEmail({
    required GoogleSignInAccount? currentUser,
    List<String>? answerList,
    required String subject,
    required String body,
    List<dynamic>? attachments,
  }) async {
    final teacherEmails = await getTeacherEmails();

    if (teacherEmails.isNotEmpty) {
      await emailSender.sendEmailToTeacher(
        currentUser: currentUser,
        attachments: (attachments != null)
            ? attachments.map((a) => a is File ? a.path : a.toString()).toList()
            : [],
        recipients: teacherEmails,
        subject: subject,
        body: body,
      );
    } else {
      throw Exception('Nenhum e-mail de professor encontrado');
    }
  }

  @override
  Future<List<String>> getStudentInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final studentInfo = await _repository.getUserInfo();
    final studentInformation = studentInfo.split('/');

    return studentInformations
      ..add(studentInformation[0])
      ..add(studentInformation[1])
      ..add(studentInformation[2]);
  }

  @override
  Future<List<String>> getSchoolsInfo() async {
    final schoolsRef = FirebaseFirestore.instance.collection('escolas');
    final schools = <String>[];

    try {
      await schoolsRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final schoolName = doc.data();
          if (schoolName == null) return;
          schools.add((schoolName as Map)['schoolName']);
        }
      });
    } catch (error) {
      error.toString();
    }

    return schools;
  }

  @override
  Future<String> getSchoolId(String schoolNameParams) async {
    final schoolsRef = FirebaseFirestore.instance.collection('escolas');
    var schoolId = '';

    try {
      await schoolsRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final schoolName = doc.data();
          if (schoolName == null) return;
          if ((schoolName as Map)['schoolName'] == schoolNameParams) {
            schoolId = doc.id;
          }
        }
      });
    } catch (error) {
      error.toString();
    }
    return schoolId;
  }

  @override
  Future<List<String>> getClassRoomInfo(String schoolName) async {
    final schoolId = await getSchoolId(schoolName);
    final classRoomRef = FirebaseFirestore.instance
        .collection('escolas/')
        .doc('$schoolId/')
        .collection('turmas');
    final classRoom = <String>[];

    try {
      await classRoomRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final className = doc.data();
          if (className == null) return;
          classRoom.add((className as Map)['classRoom']);
        }
      });
    } catch (error) {
      error.toString();
    }

    return classRoom;
  }

  @override
  Future<List<String>?> getClassroomStudentNames() async {
    List<String>? studentsList = [];

    try {
      studentsList = await _repository.getStudents();
    } on FirebaseException catch (e) {
      e.toString();
    }
    return studentsList;
  }
}
