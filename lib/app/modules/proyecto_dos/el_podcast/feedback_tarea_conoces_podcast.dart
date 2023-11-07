import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaConocesPodcast extends StatefulWidget {
  const FeedbackTareaConocesPodcast({super.key});

  @override
  State<FeedbackTareaConocesPodcast> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackTareaConocesPodcast> {
  final String firebaseDoc = 'dos/feedback/conoces_podcast/tarea/feedback';
  final String pageTitle = Strings.titleConocesPodcast;
  final String tareaTitle = Strings.titlefeedbackConocesPodcast;
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
