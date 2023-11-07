import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../commons/strings/strings_grabacion_podcast.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosGrabacionPodcast extends StatefulWidget {
  const FeedbackTareaDosGrabacionPodcast({super.key});

  @override
  State<FeedbackTareaDosGrabacionPodcast> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackTareaDosGrabacionPodcast> {
  final String firebaseDoc =
      'dos/feedback/creacion-encuesta/tarea-dos/feedback';
  final String pageTitle = Strings.titleGrabacionPodcast;
  final String tareaTitle =
      StringsGrabacionPodcast.feedbackTitleTareaDosGrabacionPodcast;
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
