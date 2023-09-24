import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosLaEncuesta extends StatefulWidget {
  const FeedbackTareaDosLaEncuesta({super.key});

  @override
  State<FeedbackTareaDosLaEncuesta> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackTareaDosLaEncuesta> {
  final String firebaseDoc = 'dos/feedback/la-encuesta/tarea-dos/feedback';
  final String pageTitle = Strings.titleLaEncuesta;
  final String tareaTitle =
      StringsLaEncuesta.titleFeedbackTareaDosComoCrearUnaEncuesta;
  final String taskCompleted = 'queEsUnaEncuestaTareaDosCompleted';

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
