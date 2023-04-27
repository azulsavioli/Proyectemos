import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' hide Color;
import 'package:image_picker/image_picker.dart';
import 'package:proyectemos/services/toast_services.dart';

import '../../../commons/styles.dart';
import 'custom_text_form_field.dart';

class CustomStepInheritedWidget extends InheritedWidget {
  final bool buttonFileSelected;
  final bool buttonCameraSelected;
  final Icon buttonFileIcon;
  final Icon buttonCameraIcon;
  final Color buttonFileColor;
  final Color buttonCameraColor;

  const CustomStepInheritedWidget({
    Key? key,
    required Widget child,
    required this.buttonFileSelected,
    required this.buttonCameraSelected,
    required this.buttonFileIcon,
    required this.buttonCameraIcon,
    required this.buttonFileColor,
    required this.buttonCameraColor,
  }) : super(key: key, child: child);

  static CustomStepInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CustomStepInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CustomStepInheritedWidget oldWidget) {
    return buttonFileSelected != oldWidget.buttonFileSelected ||
        buttonCameraSelected != oldWidget.buttonCameraSelected ||
        buttonFileIcon != oldWidget.buttonFileIcon ||
        buttonCameraIcon != oldWidget.buttonCameraIcon ||
        buttonFileColor != oldWidget.buttonFileColor ||
        buttonCameraColor != oldWidget.buttonCameraColor;
  }
}

class CustomStep extends StatefulWidget {
  final String title;
  final int currentStep;
  final int stepIndex;
  final TextEditingController controller;

  const CustomStep({
    Key? key,
    required this.title,
    required this.currentStep,
    required this.stepIndex,
    required this.controller,
  }) : super(key: key);

  static List<XFile> images = [];

  @override
  State<CustomStep> createState() => _CustomStepState();
}

class _CustomStepState extends State<CustomStep> {
  bool buttonFileSelected = false;
  bool buttonCameraSelected = false;
  Icon buttonFileIcon = const Icon(Icons.image_outlined);
  Icon buttonCameraIcon = const Icon(Icons.camera_alt_outlined);
  Color buttonFileColor = ThemeColors.red;
  Color buttonCameraColor = ThemeColors.yellow;
  File? image;

  Future pickImage(List<XFile> images, ImageSource source) async {
    if (images.length >= 10) images = [];
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final bytes = await File(image.path).readAsBytes();
    final imagemfinal = decodeImage(bytes);

    final compressedImage = encodeJpg(imagemfinal!, quality: 50);

    final temporaryImage = await File(image.path).writeAsBytes(compressedImage);

    setState(() => this.image = temporaryImage);
    images.add(image);
    return image;
  }

  void validate(BuildContext context) {
    return showToast('¡Por favor seleccione su imagen!');
  }

  @override
  Widget build(BuildContext context) {
    return CustomStepInheritedWidget(
      buttonFileSelected: buttonFileSelected,
      buttonCameraSelected: buttonCameraSelected,
      buttonFileIcon: buttonFileIcon,
      buttonCameraIcon: buttonCameraIcon,
      buttonFileColor: buttonFileColor,
      buttonCameraColor: buttonCameraColor,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleciona una imagen de su camara o de su arquivo',
              style: ThemeText.paragraph14Gray,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(buttonFileColor),
                    ),
                    onPressed: () async {
                      final image = await pickImage(
                        CustomStep.images,
                        ImageSource.gallery,
                      );
                      if (image == null) {
                        validate(context);
                      } else if (image != null) {
                        setState(() {
                          buttonFileColor = ThemeColors.green;
                          buttonFileIcon = const Icon(Icons.check);
                          buttonFileSelected = true;
                        });
                      }
                    },
                    icon: buttonFileIcon,
                    label: const Text('Galería'),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Expanded(
                //   child: ElevatedButton.icon(
                //       style: ButtonStyle(
                //         backgroundColor:
                //             MaterialStateProperty.all(buttonCameraColor),
                //       ),
                //       onPressed: () async {
                //         final image = await pickImage(
                //             CustomStep.images, ImageSource.camera);
                //         if (image == null) {
                //           validate(context);
                //         } else if (image != null) {
                //           setState(() {
                //             buttonCameraColor = ThemeColors.green;
                //             buttonCameraIcon = const Icon(Icons.check);
                //             buttonCameraSelected = true;
                //           });
                //         }
                //       },
                //       icon: buttonCameraIcon,
                //       label: const Text('Cámara')),
                // ),
              ],
            ),
            const Divider(),
            Text(
              'Cual la descripción de esa imagen',
              style: ThemeText.paragraph14Gray,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              hint: 'Respuesta',
              controller: widget.controller,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
              validatorNumeroDeCaracteres: 3,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
