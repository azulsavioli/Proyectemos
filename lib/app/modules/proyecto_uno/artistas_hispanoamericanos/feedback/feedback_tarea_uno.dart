import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaUnoArtistas extends StatefulWidget {
  const FeedbackTareaUnoArtistas({super.key});

  @override
  State<FeedbackTareaUnoArtistas> createState() =>
      _FeedbackTareaUnoArtistasState();
}

class _FeedbackTareaUnoArtistasState extends State<FeedbackTareaUnoArtistas> {
  final String firebaseDoc = 'uno/feedback/artistas/tarea_uno/feedback';
  final String pageTitle = Strings.titleArtistasHispanoamericanosUno;
  final String tareaTitle = Strings.feedbackTareaUno;
  final String taskCompleted = 'artistasTareaUnoReceivedFeedbackCompleted';

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
