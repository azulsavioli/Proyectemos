import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaUnoLatinoamerica extends StatefulWidget {
  const FeedbackTareaUnoLatinoamerica({super.key});

  @override
  State<FeedbackTareaUnoLatinoamerica> createState() =>
      _FeedbackTareaUnoLatinoamericaState();
}

class _FeedbackTareaUnoLatinoamericaState
    extends State<FeedbackTareaUnoLatinoamerica> {
  final String firebaseDoc = 'uno/feedback/latinoamerica/tarea_uno/feedback';
  final String pageTitle = Strings.titleLatinoamericaUnoFeedback;
  final String tareaTitle = Strings.feedbackTareaUno;
  final String taskCompleted = 'latinoamericaTareaUnoReceivedFeedbackCompleted';

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
