import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase/db_firestore_helper.dart';

class ProyectemosRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  AuthService authService = AuthService();
  late SharedPreferences sharedPreferences;
  String studentSchoolInfo = '';
  String studentClassRoomInfo = '';

  ProyectemosRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<List<DocumentSnapshot>> getAllSchools() async {
    var schools;

    await FirebaseFirestore.instance
        .collection('escolas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      schools = querySnapshot.docs;
    });

    return schools;
  }

  Future<String> getSchoolId(String schoolNameParams) async {
    final schoolsRef = FirebaseFirestore.instance.collection('escolas');
    String schoolId = '';

    try {
      await schoolsRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final schoolName = doc.data();
          if (schoolName == null) return;
          if ((schoolName as Map)['schoolName'] == schoolNameParams) {
            schoolId = doc.id.toString();
          }
        }
      });
    } catch (error) {
      error.toString();
    }
    return schoolId;
  }

  Future<String> getClassRoomId(String schoolId, String classNameParams) async {
    final classRoomRef = FirebaseFirestore.instance
        .collection('escolas/')
        .doc('$schoolId/')
        .collection('turmas');
    String classRoomId = '';

    try {
      await classRoomRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final className = doc.data();
          if (className == null) return;
          if ((className as Map)['classRoom'] == classNameParams) {
            classRoomId = doc.id.toString();
            break;
          }
        }
      });
    } catch (error) {
      error.toString();
    }
    return classRoomId;
  }

  Future<void> saveAnswers<T>(String task, Map<String, T> answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('alunos')
        .doc(authService.userAuth?.uid)
        .collection(task);
    try {
      // await studentTaskRef.add(answer);
      await studentTaskRef.doc().set(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Future getAnswers(String task) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final tasksAnswers = [];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('alunos')
        .doc(authService.userAuth?.uid)
        .collection(task);
    try {
      await studentTaskRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final task = doc.data();
          if (task == null) return;
          tasksAnswers.add(task);
        }
      });
    } on FirebaseException catch (e) {
      return e.toString();
    }
    notifyListeners();
    return tasksAnswers;
  }

  Future saveImagesTurma(answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('imagens_turma')
        .doc(authService.userAuth?.uid)
        .collection('imagens');

    try {
      await studentTaskRef.add(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>?> getImagesTurmaStream() async* {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final studentsImages = [];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('imagens_turma');

    try {
      await studentTaskRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          studentsImages.add(doc.data());
        }
      });
    } catch (error) {
      error.toString();
    }
    yield studentsImages.cast<Map<String, dynamic>>();
  }

  Future saveVideosPublic(answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('videos_publicos_evento_cultural');

    try {
      await studentTaskRef.add(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> getVideosPublic() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final videosStudents = [];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return null;
    }

    final videosPublicRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('videos_publicos_evento_cultural');

    try {
      await videosPublicRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          videosStudents.add(doc.data());
        }
      });
    } catch (error) {
      error.toString();
    }
    notifyListeners();

    return videosStudents.cast<Map<String, dynamic>>();
  }

  Future saveVideosTurma(answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('videos_turma')
        .doc(authService.userAuth?.uid)
        .collection('videos');

    try {
      await studentTaskRef.add(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> getVideosTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final studentsImages = [];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return null;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('videos_turma')
        .doc(authService.userAuth?.uid)
        .collection('videos');

    try {
      await studentTaskRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          studentsImages.add(doc.data());
        }
      });
    } catch (error) {
      error.toString();
    }
    notifyListeners();

    return studentsImages.cast<Map<String, dynamic>>();
  }

  Future getTeacherEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final teacherInfo = [];
    final teacherEmailList = [];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return null;
    }

    final teacherInfoRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('professores');

    try {
      await teacherInfoRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          teacherInfo.add(doc.data());
        }
        for (var i = 0; i < teacherInfo.length; i++) {
          teacherEmailList.add(teacherInfo[i]['teacherEmail']);
        }
      });
    } catch (error) {
      error.toString();
    }
    notifyListeners();

    return teacherEmailList;
  }

  Future<String> getUserInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();

    final studentSchoolTemp = sharedPreferences.getString('studentSchoolInfo');
    final studentClassRoomTemp =
        sharedPreferences.getString('studentClassRoomInfo');

    if (studentSchoolTemp == null || studentClassRoomTemp == null) {
      throw Exception('studentSchoolInfo or studentClassRoomInfo is null');
    }

    final studentSchoolInfo = studentSchoolTemp;
    final studentClassRoomInfo = studentClassRoomTemp;

    final studentInfo =
        '${authService.userAuth!.displayName}/$studentSchoolInfo/$studentClassRoomInfo';

    return studentInfo;
  }

  Future<String>? getUserAuthToken() {
    return authService.userAuth?.getIdToken();
  }
}
