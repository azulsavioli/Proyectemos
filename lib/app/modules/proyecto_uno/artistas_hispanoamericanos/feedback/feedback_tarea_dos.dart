import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosArtistas extends StatefulWidget {
  const FeedbackTareaDosArtistas({super.key});

  @override
  State<FeedbackTareaDosArtistas> createState() =>
      _FeedbackTareaDosArtistasState();
}

class _FeedbackTareaDosArtistasState extends State<FeedbackTareaDosArtistas> {
  final String firebaseDoc = 'uno/feedback/artistas/tarea_dos/feedback';
  final String pageTitle = Strings.titleArtistasHispanoamericanosUno;
  final String tareaTitle = Strings.feedbackTareaDos;
  final String taskCompleted = 'artistasTareaDosReceivedFeedbackCompleted';

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
