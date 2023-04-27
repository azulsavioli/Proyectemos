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

  Future saveImagesTurma(answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');

    await db.collection('escola/$studentInfo/imagens_turma/').doc().set(answer);

    notifyListeners();
  }

  Future saveAnswersPublic(doc, answer) async {
    await db.collection('escola/videos/public/').doc(doc).set(answer);
    notifyListeners();
  }

  Future getVideosPublic(String doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final tasksAnswers = [];

    final DocumentReference document =
        db.collection('escola/videos/public/').doc('/$doc');

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

  Future saveVideosTurma(String doc, answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('escola/$studentInfo/videos_turma/')
        .doc(doc)
        .set(answer);

    notifyListeners();
  }

  Future getVideosTurma(String doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    final tasksAnswers = [];

    final DocumentReference document =
        db.collection('escola/$studentInfo/videos_turma/').doc('/$doc');

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

  // Future getImagesTurma() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   studentInfo = sharedPreferences.getString('studentInfo');
  //   final studentsImages = [];

  //   final DocumentReference document =
  //       db.collection('escola/$studentInfo/imagens_turma/').doc();

  //   try {
  //     await document.get().then((snapshot) {
  //       if (snapshot.data() != null) {
  //         studentsImages.add(snapshot.data());
  //       }
  //     });
  //   } on FirebaseException catch (e) {
  //     return e.toString();
  //   }
  //   notifyListeners();
  //   return studentsImages;
  // }

  // Future getStreamSnapshot() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   studentInfo = sharedPreferences.getString('studentInfo');

  //   try {
  //     db
  //         .collection(
  //           'escola/$studentInfo/imagens_latinoamerica/alunos_feed/',
  //         )
  //         .orderBy('postTimeStamp', descending: true)
  //         .snapshots();
  //   } on FirebaseException catch (e) {
  //     return e.toString();
  //   }
  //   notifyListeners();
  // }

  // Future getLatinoamericaImages() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   studentInfo = sharedPreferences.getString('studentInfo');
  //   final imagesLatinoamerica = [];
  //   final emailsMatch =
  //       RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');

  //   try {
  //     await db
  //         .collection(
  //           'escola/$studentInfo/imagens_latinoamerica/alunos/alunos_feed/',
  //         )
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       for (final doc in querySnapshot.docs) {
  //         imagesLatinoamerica.add(doc);
  //       }
  //     });
  //   } on FirebaseException catch (e) {
  //     return e.toString();
  //   }
  //   notifyListeners();
  //   return imagesLatinoamerica;
  // }

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
