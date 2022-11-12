import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/services/auth_services.dart';
import 'package:proyectemos/services/firebase/db_firestore_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  saveAnswers(doc, answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('educandos/$studentInfo/${authService.userAuth!.uid}/')
        .doc(doc)
        .set(answer);

    notifyListeners();
  }

  removeAnswers(doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('educandos/$studentInfo${authService.userAuth!.uid}/')
        .doc(doc)
        .delete();

    notifyListeners();
  }

  String getUserInfo() {
    return '$studentInfo/${authService.userAuth!.displayName}';
  }

  getUserAuthToken() {
    return authService.userAuth?.getIdToken();
  }
}
