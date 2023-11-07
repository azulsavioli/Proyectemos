import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/widgets/feedback_page.dart';
import 'package:proyectemos/commons/strings/strings_grabacion_podcast.dart';

import '../../../../../commons/strings/strings.dart';

class FeedbackTareaUnoGrabacionPodcast extends StatefulWidget {
  const FeedbackTareaUnoGrabacionPodcast({super.key});

  @override
  State<FeedbackTareaUnoGrabacionPodcast> createState() =>
      _FeedbackTareaUnoGrabacionPodcast();
}

class _FeedbackTareaUnoGrabacionPodcast
    extends State<FeedbackTareaUnoGrabacionPodcast> {
  final String firebaseDoc =
      'dos/feedback/creacion-encuesta/tarea-uno/feedback';
  final String pageTitle = Strings.titleGrabacionPodcast;
  final String tareaTitle =
      StringsGrabacionPodcast.feedbackTitleTareaUnoGrabacionPodcast;
  final String taskCompleted = 'grabacionPodcastTareaUnoCompleted';

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
