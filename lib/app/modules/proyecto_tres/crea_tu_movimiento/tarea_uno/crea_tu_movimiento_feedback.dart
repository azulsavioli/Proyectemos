import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_crea_tu_movimiento.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../widgets/feedback_page.dart';

class FeedbackCreaTuMovimientoTareaUno extends StatefulWidget {
  const FeedbackCreaTuMovimientoTareaUno({super.key});

  @override
  State<FeedbackCreaTuMovimientoTareaUno> createState() =>
      _FeedbackTareaStateConocesPodcast();
}

class _FeedbackTareaStateConocesPodcast
    extends State<FeedbackCreaTuMovimientoTareaUno> {
  final String firebaseDoc =
      'tres/feedback/crea-tu-movimiento/tarea-uno/feedback';
  final String pageTitle = Strings.titleCreaTuMovimiento;
  final String tareaTitle = StringsCreaTuMovimiento.titleTareaUno;
  final String taskCompleted = 'creaTuMovimientoTareaUnoCompleted';

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
