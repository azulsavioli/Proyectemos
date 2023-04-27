import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaTresLatinoamerica extends StatefulWidget {
  const FeedbackTareaTresLatinoamerica({super.key});

  @override
  State<FeedbackTareaTresLatinoamerica> createState() =>
      _FeedbackTareaTresLatinoamericaState();
}

class _FeedbackTareaTresLatinoamericaState
    extends State<FeedbackTareaTresLatinoamerica> {
  final String firebaseDoc = 'uno/feedback/latinoamerica/tarea_tres/feedback';
  final String pageTitle = Strings.titleLatinoamericaUnoFeedback;
  final String tareaTitle = Strings.feedbackTareaTres;
  final String taskCompleted =
      'latinoamericaTareaTresReceivedFeedbackCompleted';

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
