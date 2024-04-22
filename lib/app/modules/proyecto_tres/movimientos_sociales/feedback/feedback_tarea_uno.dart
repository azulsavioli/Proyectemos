import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackMovimientosSociales extends StatefulWidget {
  const FeedbackMovimientosSociales({super.key});

  @override
  State<FeedbackMovimientosSociales> createState() =>
      _FeedbackMovimientosSocialesState();
}

class _FeedbackMovimientosSocialesState
    extends State<FeedbackMovimientosSociales> {
  final String firebaseDoc =
      'tres/feedback/movimientosSociales/tarea_uno/feedback';
  final String pageTitle = Strings.movimientoSociale;
  final String tareaTitle = Strings.movimientoSociale;
  final String taskCompleted = 'movimientosSocialesFeedbackCompleted';

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
