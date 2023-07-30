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
  TextEditingController controllerSeis,
  TextEditingController controllerSiete,
  TextEditingController controllerOcho,
  TextEditingController controllerNueve,
  TextEditingController controllerDiez,
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
    Step(
      title: const Text('Etapa 6'),
      content: CustomStep(
        title: 'Sesta imagen',
        stepIndex: 6,
        currentStep: 6,
        controller: controllerSeis,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 7'),
      content: CustomStep(
        title: 'Septima imagen',
        stepIndex: 7,
        currentStep: 7,
        controller: controllerSiete,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 8'),
      content: CustomStep(
        title: 'Ochava imagen',
        stepIndex: 8,
        currentStep: 8,
        controller: controllerOcho,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 9'),
      content: CustomStep(
        title: 'Nuena imagen',
        stepIndex: 9,
        currentStep: 9,
        controller: controllerNueve,
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Etapa 10'),
      content: CustomStep(
        title: 'Decima imagen',
        stepIndex: 10,
        currentStep: 10,
        controller: controllerDiez,
      ),
      isActive: true,
    ),
  ];
}
