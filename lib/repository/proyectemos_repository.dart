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
            schoolId = doc.id;
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
    var classRoomId = '';

    try {
      await classRoomRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final className = doc.data();
          if (className == null) return;
          if ((className as Map)['classRoom'] == classNameParams) {
            classRoomId = doc.id;
            break;
          }
        }
      });
    } catch (error) {
      error.toString();
    }
    return classRoomId;
  }

  Future<String> getStudentListId(String schoolId, String classroomId) async {
    final studentsRef = FirebaseFirestore.instance
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('lista_alunos');

    var lastStudentId = '';

    try {
      await studentsRef.get().then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          lastStudentId =
              querySnapshot.docs.last.id; // Pega o ID do último documento
        }
      });
    } catch (error) {
      print(error.toString());
    }

    return lastStudentId;
  }

  Future<List<String>> getStudents() async {
    List<String> studentsList = [];
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);
    final studentListId = await getStudentListId(schoolId, classroomId);
    if (schoolId.isEmpty || classroomId.isEmpty) {
      return studentsList;
    }

    final DocumentReference classRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('lista_alunos')
        .doc(studentListId);

    try {
      await classRef.get().then((DocumentSnapshot docSnapshot) {
        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            for (final key in data.keys) {
              if (key.startsWith('nome_aluno')) {
                studentsList.add(data[key]);
              }
            }
          }
        }
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      // Here you can handle the error. Maybe return an empty list or show a message.
    }
    notifyListeners();
    return studentsList;
  }

  Future<void> saveClassroomStudents<T>(
    Map<String, T> classroomStudents,
  ) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return;
    }

    final studentClassroomRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('lista_alunos');
    try {
      await studentClassroomRef.doc().set(classroomStudents);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
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
        .doc(authService.userAuth?.uid);

    try {
      await studentTaskRef.set(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> getImagesTurmaStream() {
    return Stream.fromFuture(_getImagesTurma());
  }

  Future<List<Map<String, dynamic>>> _getImagesTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final studentsImages = <Map<String, dynamic>>[];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return studentsImages;
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
          studentsImages.add(doc.data()! as Map<String, dynamic>);
        }
      });
    } catch (error) {
      print(error);
    }
    return studentsImages;
  }

  Future savePodcastTurma(answer) async {
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
        .collection('podcast_turma')
        .doc(authService.userAuth?.uid);

    try {
      await studentTaskRef.set(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Future saveMovimientoSocialeTurma(answer) async {
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
        .collection('movimiento_sociale_turma')
        .doc(authService.userAuth?.uid);

    try {
      await studentTaskRef.set(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> getMovimientoSocialeTurmaStream() {
    return Stream.fromFuture(_getMovimientoTurma());
  }

  Stream<List<Map<String, dynamic>>> getPodcastTurmaStream() {
    return Stream.fromFuture(_getPodcastTurma());
  }

  Future<List<Map<String, dynamic>>> _getPodcastTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final studentsImages = <Map<String, dynamic>>[];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return studentsImages;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection('podcast_turma');

    try {
      await studentTaskRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          studentsImages.add(doc.data()! as Map<String, dynamic>);
        }
      });
    } catch (error) {
      print(error);
    }
    return studentsImages;
  }

  Future<List<Map<String, dynamic>>> _getMovimientoTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentSchoolInfo = sharedPreferences.getString('studentSchoolInfo')!;
    studentClassRoomInfo = sharedPreferences.getString('studentClassRoomInfo')!;
    final studentsImages = <Map<String, dynamic>>[];

    final schoolId = await getSchoolId(studentSchoolInfo);
    final classroomId = await getClassRoomId(schoolId, studentClassRoomInfo);

    if (schoolId.isEmpty || classroomId.isEmpty) {
      return studentsImages;
    }

    final studentTaskRef = db
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas')
        .doc(classroomId)
        .collection("movimiento_sociale_turma");

    try {
      await studentTaskRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          studentsImages.add(doc.data()! as Map<String, dynamic>);
        }
      });
    } catch (error) {
      print(error);
    }
    return studentsImages;
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
        .collection('videos_divulgacion');

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
        .collection('videos_divulgacion');

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

  Future saveVideosMovimientosSocialesTurma(answer) async {
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
        .collection('videos_movimientos_sociales');

    try {
      await studentTaskRef.add(answer);
    } on Exception catch (e) {
      e.toString();
    }
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?>
      getVideosMovimientosSocialesTurma() async {
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
        .collection('videos_movimientos_sociales');

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
        .collection('professore');

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

  Future<String?>? getUserAuthToken() {
    return authService.userAuth?.getIdToken();
  }
}
