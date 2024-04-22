import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_crea_tu_movimiento.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackCreaTuMovimientoTareaDos extends StatefulWidget {
  const FeedbackCreaTuMovimientoTareaDos({super.key});

  @override
  State<FeedbackCreaTuMovimientoTareaDos> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackCreaTuMovimientoTareaDos> {
  final String firebaseDoc =
      'tres/feedback/crea-tu-movimiento/tarea-dos/feedback';
  final String pageTitle = Strings.titleCreaTuMovimiento;
  final String tareaTitle = StringsCreaTuMovimiento.titleTareaDos;
  final String taskCompleted = 'creaTuMovimientoTareaDosCompleted';

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
