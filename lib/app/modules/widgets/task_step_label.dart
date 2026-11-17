import 'package:flutter/material.dart';

import '../../../commons/styles.dart';
import 'spanish_text.dart';

/// Learning-task progress. The wording stays Spanish, as in the activities.
class TaskStepLabel extends StatelessWidget {
  final int current;
  final int total;

  const TaskStepLabel({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SpanishText(
        'Paso $current de $total',
        style: ThemeText.paragraph12Gray,
        textAlign: TextAlign.center,
      ),
    );
  }
}
