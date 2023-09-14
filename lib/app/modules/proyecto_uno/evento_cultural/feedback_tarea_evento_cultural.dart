import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaEventoCultural extends StatefulWidget {
  const FeedbackTareaEventoCultural({super.key});

  @override
  State<FeedbackTareaEventoCultural> createState() =>
      _FeedbackTareaStateEventoCultural();
}

class _FeedbackTareaStateEventoCultural
    extends State<FeedbackTareaEventoCultural> {
  final String firebaseDoc = 'uno/feedback/evento_cultural/tarea/feedback';
  final String pageTitle = Strings.titleEventoCulturalUno;
  final String tareaTitle = Strings.titleEventoCulturalUnoFeed;
  final String taskCompleted = 'eventoReceivedFeedbackCompleted';

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
