import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaLaSociedad extends StatefulWidget {
  const FeedbackTareaLaSociedad({super.key});

  @override
  State<FeedbackTareaLaSociedad> createState() =>
      _FeedbackTareaLaSociedadState();
}

class _FeedbackTareaLaSociedadState extends State<FeedbackTareaLaSociedad> {
  final String firebaseDoc = 'tres/feedback/laSociedad/tarea_uno/feedback';
  final String pageTitle = Strings.titleLaSociedadFeedback;
  final String tareaTitle = Strings.titleLaSociedadFeedback;
  final String taskCompleted = 'laSociedadTareaUnoReceivedFeedbackCompleted';

  @override
  Widget build(BuildContext context) {
    return FeedbackPage(
      firebaseDoc: firebaseDoc,
      pageTitle: pageTitle,
      tareaTitle: tareaTitle,
      taskCompleted: taskCompleted,
    );
  }
}
