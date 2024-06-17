import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/styles.dart';
import '../../../repository/proyectemos_repository.dart';
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
      e.toString();
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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, size: isMobile ? 20 : 50),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          toolbarHeight: isMobile ? 60 : 90,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: ThemeColors.white, size: isMobile ? 20 : 40),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          title: Text(
            widget.pageTitle,
            style: ThemeText.paragraph14WhiteBold,
          ),
        ),
        endDrawer: DrawerMenuWidget(),
        body: Padding(
          padding: isMobile? EdgeInsets.fromLTRB(16, 30, 16, 16) : EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.tareaTitle,
                style: isMobile
                    ? ThemeText.paragraph16BlueNormal
                    : ThemeText.paragraph14Blue,
              ),
              SizedBox(
                height: isMobile ? 20 : 40,
              ),
              Text(
                feedback,
                style: isMobile
                    ? ThemeText.paragraph14Gray
                    : ThemeText.paragraph12Gray,
              ),
              SizedBox(
                height: isMobile ? 20 : 40,
              ),
              SizedBox(
                height:  isMobile ? 60 : 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, isMobile ? 50 : 120),
                      backgroundColor: ThemeColors.yellow),
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
