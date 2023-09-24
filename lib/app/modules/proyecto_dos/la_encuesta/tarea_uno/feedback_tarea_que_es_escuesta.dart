import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaUnoLaEncuesta extends StatefulWidget {
  const FeedbackTareaUnoLaEncuesta({super.key});

  @override
  State<FeedbackTareaUnoLaEncuesta> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackTareaUnoLaEncuesta> {
  final String firebaseDoc = 'dos/feedback/la-encuesta/tarea-uno/feedback';
  final String pageTitle = Strings.titleLaEncuesta;
  final String tareaTitle =
      StringsLaEncuesta.titleFeedbackTareaUnoQueEsUnaEncuesta;
  final String taskCompleted = 'queEsUnaEncuestaTareaUnoCompleted';

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
