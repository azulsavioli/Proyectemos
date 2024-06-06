import 'package:flutter/material.dart';

import '../../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTuAlrededor extends StatefulWidget {
  const FeedbackTuAlrededor({super.key});

  @override
  State<FeedbackTuAlrededor> createState() => _FeedbackTuAlrededorState();
}

class _FeedbackTuAlrededorState extends State<FeedbackTuAlrededor> {
  final String firebaseDoc = 'tres/feedback/tuAlrededor/tarea_uno/feedback';
  final String pageTitle = Strings.titleTuAlrededorFeedback;
  final String tareaTitle = Strings.titleTuAlrededorFeedback;
  final String taskCompleted = 'tuAlrededorCompleted';

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
