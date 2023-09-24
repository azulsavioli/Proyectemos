import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosComoCrearPodcast extends StatefulWidget {
  const FeedbackTareaDosComoCrearPodcast({super.key});

  @override
  State<FeedbackTareaDosComoCrearPodcast> createState() =>
      _FeedbackTareaDosStateComoCrearPodcast();
}

class _FeedbackTareaDosStateComoCrearPodcast
    extends State<FeedbackTareaDosComoCrearPodcast> {
  final String firebaseDoc =
      'dos/feedback/como_crear_un_podcast/tarea_dos/feedback';
  final String pageTitle = Strings.titleComoCrearPodcast;
  final String tareaTitle = Strings.titlefeedbackComoCrearPodcast;
  final String taskCompleted = 'comoCrearPodcastTareaDosCompleted';

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
