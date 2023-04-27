import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosLatinoamerica extends StatefulWidget {
  const FeedbackTareaDosLatinoamerica({super.key});

  @override
  State<FeedbackTareaDosLatinoamerica> createState() =>
      _FeedbackTareaDosLatinoamericaState();
}

class _FeedbackTareaDosLatinoamericaState
    extends State<FeedbackTareaDosLatinoamerica> {
  final String firebaseDoc = 'uno/feedback/latinoamerica/tarea_dos/feedback';
  final String pageTitle = Strings.titleLatinoamericaUnoFeedback;
  final String tareaTitle = Strings.feedbackTareaDos;
  final String taskCompleted = 'latinoamericaTareaDosReceivedFeedbackCompleted';

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
