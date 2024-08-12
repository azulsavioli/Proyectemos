import 'package:flutter/material.dart';

import '../../../../commons/styles.dart';
import 'custom_step_item.dart';

List<Step> steps(
  TextEditingController controllerUno,
  TextEditingController controllerDos,
  TextEditingController controllerTres,
  TextEditingController controllerQuatro,
  TextEditingController controllerCinco,
  bool isMobile,
) {
  return [
    Step(
      title: Text('Primera imagen',
          style: isMobile
              ? ThemeText.paragraph16GrayNormal
              : ThemeText.paragraph14Gray),
      content: CustomStep(
        controller: controllerUno,
      ),
      isActive: true,
    ),
    Step(
      title: Text('Segunda imagen',
          style: isMobile
              ? ThemeText.paragraph16GrayNormal
              : ThemeText.paragraph14Gray),
      content: CustomStep(
        controller: controllerDos,
      ),
      isActive: true,
    ),
    Step(
      title: Text('Tercera imagen',
          style: isMobile
              ? ThemeText.paragraph16GrayNormal
              : ThemeText.paragraph14Gray),
      content: CustomStep(
        controller: controllerTres,
      ),
      isActive: true,
    ),
    Step(
      title: Text('Cuarta imagen',
          style: isMobile
              ? ThemeText.paragraph16GrayNormal
              : ThemeText.paragraph14Gray),
      content: CustomStep(
        controller: controllerQuatro,
      ),
      isActive: true,
    ),
    Step(
      title: Text('Quinta imagen',
          style: isMobile
              ? ThemeText.paragraph16GrayNormal
              : ThemeText.paragraph14Gray),
      content: CustomStep(
        controller: controllerCinco,
      ),
      isActive: true,
    ),
  ];
}
