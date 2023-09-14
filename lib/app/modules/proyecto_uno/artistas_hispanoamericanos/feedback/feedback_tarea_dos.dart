import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackTareaDosArtistas extends StatefulWidget {
  const FeedbackTareaDosArtistas({super.key});

  @override
  State<FeedbackTareaDosArtistas> createState() =>
      _FeedbackTareaDosArtistasState();
}

class _FeedbackTareaDosArtistasState extends State<FeedbackTareaDosArtistas> {
  final String firebaseDoc = 'uno/feedback/artistas/tarea_dos/feedback';
  final String pageTitle = Strings.titleArtistasHispanoamericanos;
  final String tareaTitle = Strings.titleArtistasHispanoamericanosDos;
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
