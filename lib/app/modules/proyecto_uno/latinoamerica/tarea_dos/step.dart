import 'package:flutter/material.dart';

import '../../../../../commons/strings_latinoamerica.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/step.dart';

List<Step> steps(
  TextEditingController controllerUno,
  TextEditingController controllerDos,
  TextEditingController controllerTres,
  TextEditingController controllerQuatro,
  TextEditingController controllerCinco,
) {
  return [
    Step(
      title: Text(
        StringsLationamerica.titleQOnePageTresLatin,
        style: ThemeText.paragraph16BlueBold,
      ),
      content: Text(
        StringsLationamerica.descriptionqOnePageTres,
        style: ThemeText.paragraph14Gray,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 1'),
      content: CustomStep(
        title: 'Primera imagen',
        stepIndex: 1,
        currentStep: 1,
        controller: controllerUno,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 2'),
      content: CustomStep(
        title: 'Segunda imagen',
        stepIndex: 2,
        currentStep: 2,
        controller: controllerDos,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 3'),
      content: CustomStep(
        title: 'Tercera imagen',
        stepIndex: 3,
        currentStep: 3,
        controller: controllerTres,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 4'),
      content: CustomStep(
        title: 'Cuarta imagen',
        stepIndex: 4,
        currentStep: 4,
        controller: controllerQuatro,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 5'),
      content: CustomStep(
        title: 'Quinta imagen',
        stepIndex: 5,
        currentStep: 5,
        controller: controllerCinco,
      ),
      isActive: true,
    ),
  ];
}
