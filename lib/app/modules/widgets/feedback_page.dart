import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/styles.dart';
import '../../proyectemos_repository.dart';
import 'drawer_menu.dart';

class FeedbackPage extends StatefulWidget {
  final String firebaseDoc;
  final String pageTitle;
  final String tareaTitle;
  final String taskCompleted;

  const FeedbackPage({
    super.key,
    required this.firebaseDoc,
    required this.pageTitle,
    required this.tareaTitle,
    required this.taskCompleted,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedback = '';

  Future<List> getFeedbackFromFirebase() async {
    final feedback = [];
    final doc = widget.firebaseDoc;
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getAnswers(doc);
      feedback.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return feedback;
  }

  @override
  void initState() {
    startFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          widget.pageTitle,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tareaTitle,
              style: ThemeText.paragraph16BlueBold,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              feedback,
              style: ThemeText.paragraph14Gray,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ThemeColors.yellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/pUno_send_email_prof',
                    arguments: widget.tareaTitle,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Contacto con la profesora',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: ThemeColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startFeedback() async {
    setState(() {
      feedback = 'Aguardando feedback';
    });
    try {
      final feedbackFirebase = await getFeedbackFromFirebase();
      if (feedbackFirebase.isEmpty) return;
      if (feedbackFirebase.isNotEmpty) {
        final feedbackItem = feedbackFirebase[0];

        setState(() {
          feedback = feedbackItem.values.first;
          saveFeedbackCompleted();
        });
      }
    } on FirebaseException {
      return;
    }
  }

  Future<void> saveFeedbackCompleted() async {
    const taskCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      widget.taskCompleted,
      taskCompleted,
    );
  }
}
