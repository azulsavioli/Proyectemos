import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaUnoComoCrearPodcast extends StatefulWidget {
  const FeedbackTareaUnoComoCrearPodcast({super.key});

  @override
  State<FeedbackTareaUnoComoCrearPodcast> createState() =>
      _FeedbackTareaUnoStateComoCrearPodcast();
}

class _FeedbackTareaUnoStateComoCrearPodcast
    extends State<FeedbackTareaUnoComoCrearPodcast> {
  final String firebaseDoc =
      'dos/feedback/como_crear_un_podcast/tarea_uno/feedback';
  final String pageTitle = Strings.titleElContenidoDelPodcast;
  final String tareaTitle = Strings.titleFeedbackEscucharPodcast;
  final String taskCompleted = 'comoCrearPodcastTareaUnoCompleted';

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
