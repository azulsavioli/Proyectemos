import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase/db_firestore_helper.dart';

class ProyectemosRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService authService;
  late SharedPreferences sharedPreferences;
  late String? studentInfo;

  ProyectemosRepository({required this.authService}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future saveAnswers(doc, answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');

    await db
        .collection('escola/$studentInfo/${authService.userAuth!.email}/')
        .doc(doc)
        .set(answer);

    notifyListeners();
  }

  Future getAnswers(String doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final tasksAnswers = [];

    final DocumentReference document = db
        .collection('escola/$studentInfo/${authService.userAuth!.email}/')
        .doc('/$doc');

    try {
      await document.get().then((snapshot) {
        if (snapshot.data() != null) {
          tasksAnswers.add(snapshot.data());
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
    studentInfo = sharedPreferences.getString('studentInfo');

    await db.collection('escola/$studentInfo/imagens_turma/').doc().set(answer);

    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> getImagesTurmaStream() async* {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('escola/$studentInfo/imagens_turma')
        .get();

    final studentsImages = querySnapshot.docs
        .map((documentSnapshot) => documentSnapshot.data())
        .toList();

    yield studentsImages.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getImagesTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final studentsImages = [];

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('escola/$studentInfo/imagens_turma')
        .get();

    for (final documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        studentsImages.add(documentSnapshot.data());
      }
    }

    notifyListeners();
    return studentsImages.cast<Map<String, dynamic>>();
  }

  Future saveVideosPublic(answer) async {
    await db
        .collection('escola/videos_public/evento_cultural/')
        .doc()
        .set(answer);
    notifyListeners();
  }

  // Stream<List<Map<String, dynamic>>> getVideosPublicStream() async* {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   studentInfo = sharedPreferences.getString('studentInfo');
  //   final videosPublic = [];

  //   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('escola/videos_public/evento_cultural/')
  //       .get();

  //   for (final documentSnapshot in querySnapshot.docs) {
  //     if (documentSnapshot.exists) {
  //       videosPublic.add(documentSnapshot.data());
  //     }
  //   }

  //   yield videosPublic.cast<Map<String, dynamic>>();
  // }

  Future<List<Map<String, dynamic>>> getVideosPublic() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final videosPublic = [];

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('escola/videos_public/evento_cultural/')
        .get();

    for (final documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        videosPublic.add(documentSnapshot.data());
      }
    }

    notifyListeners();
    return videosPublic.cast<Map<String, dynamic>>();
  }

  Future saveVideosTurma(answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db.collection('escola/$studentInfo/videos_turma/').doc().set(answer);

    notifyListeners();
  }

  // Stream<List<Map<String, dynamic>>> getVideosTurmaStream() async* {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   studentInfo = sharedPreferences.getString('studentInfo');
  //   final studentsImages = [];

  //   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('escola/$studentInfo/videos_turma/')
  //       .get();

  //   for (final documentSnapshot in querySnapshot.docs) {
  //     if (documentSnapshot.exists) {
  //       studentsImages.add(documentSnapshot.data());
  //     }
  //   }

  //   yield studentsImages.cast<Map<String, dynamic>>();
  // }

  Future<List<Map<String, dynamic>>> getVideosTurma() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final studentsImages = [];

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('escola/$studentInfo/videos_turma/')
        .get();

    for (final documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        studentsImages.add(documentSnapshot.data());
      }
    }

    notifyListeners();
    return studentsImages.cast<Map<String, dynamic>>();
  }

  Future getTeacherEmail(String doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final tasksAnswers = [];

    final DocumentReference document =
        db.collection('escola/$studentInfo/email_professora/').doc('/$doc');

    try {
      await document.get().then((snapshot) {
        if (snapshot.data() != null) {
          tasksAnswers.add(snapshot.data());
        }
      });
    } on FirebaseException catch (e) {
      return e.toString();
    }
    notifyListeners();
    return tasksAnswers;
  }

  Future removeAnswers(String doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('escola/$studentInfo${authService.userAuth!.email}/')
        .doc(doc)
        .delete();

    notifyListeners();
  }

  String getUserInfo() {
    return '$studentInfo/${authService.userAuth!.displayName}';
  }

  Future<String>? getUserAuthToken() {
    return authService.userAuth?.getIdToken();
  }
}
