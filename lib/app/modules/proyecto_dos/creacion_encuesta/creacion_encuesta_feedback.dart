import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaCreacionEncuesta extends StatefulWidget {
  const FeedbackTareaCreacionEncuesta({super.key});

  @override
  State<FeedbackTareaCreacionEncuesta> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackTareaCreacionEncuesta> {
  final String firebaseDoc = 'dos/feedback/creacion-encuesta/tarea/feedback';
  final String pageTitle = Strings.titleCreacionEncuesta;
  final String tareaTitle = Strings.titleFeedbackCreacionEncuesta;
  final String taskCompleted = 'creacionEncuestaCompleted';

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
