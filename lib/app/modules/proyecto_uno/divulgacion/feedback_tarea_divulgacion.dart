import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaDivulgacion extends StatefulWidget {
  const FeedbackTareaDivulgacion({super.key});

  @override
  State<FeedbackTareaDivulgacion> createState() =>
      _FeedbackTareaStateDivulgacion();
}

class _FeedbackTareaStateDivulgacion extends State<FeedbackTareaDivulgacion> {
  final String firebaseDoc = 'uno/feedback/divulgacion/tarea/feedback';
  final String pageTitle = Strings.titleDivulgacionUno;
  final String tareaTitle = Strings.titleDivulgacionUnoFeedback;
  final String taskCompleted = 'divulgacionTareaUnoReceivedFeedbackCompleted';

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
