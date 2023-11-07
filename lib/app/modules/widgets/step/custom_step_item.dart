import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commons/styles.dart';
import '../custom_text_form_field.dart';
import 'step_controller.dart';

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
  final _controller = StepController();
  late FocusNode focusNode;
  bool isFileLoading = false;
  bool isCameraLoading = false;
  bool isFileSelected = false;
  bool isCameraSelected = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        focusNode = FocusNode();
      });
    }
  }

  @override
  void dispose() {
    if (mounted) {
      setState(() {
        focusNode.dispose();
      });
    }
    super.dispose();
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
                if (isCameraSelected)
                  const SizedBox()
                else
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(buttonFileColor),
                      ),
                      onPressed: () async {
                        await selectImageFromGallery();
                      }

                      // onPressed: () async {
                      //   if (mounted) {
                      //     setState(() {
                      //       isFileLoading = true;
                      //     });
                      //   }

                      //   if (mounted) {
                      //     final image = await _controller.pickImage(
                      //       CustomStep.images,
                      //       ImageSource.gallery,
                      //     );
                      //     if (mounted) {
                      //       setState(() {
                      //         isFileLoading = true;
                      //       });
                      //     }

                      //     if (image == null) {
                      //       _controller.validate();
                      //     } else if (image != null) {
                      //       if (mounted) {
                      //         setState(() {
                      //           isFileLoading = false;
                      //           buttonFileColor = ThemeColors.green;
                      //           buttonFileIcon = const Icon(Icons.check);
                      //           buttonFileSelected = true;
                      //           isFileSelected = true;
                      //         });
                      //       }
                      //     }
                      //   }
                      // },
                      ,
                      icon: isFileLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : buttonFileIcon,
                      label: const Text('Galería'),
                    ),
                  ),
                const SizedBox(
                  width: 5,
                ),
                if (isFileSelected)
                  const SizedBox()
                else
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(buttonCameraColor),
                      ),
                      onPressed: () async {
                        await selectImageFromCamera();
                      },
                      // onPressed: () async {
                      //   if (mounted) {
                      //     setState(() {
                      //       isCameraLoading = true;
                      //     });
                      //   }
                      //   if (mounted) {
                      //     final image = await _controller.pickImage(
                      //       CustomStep.images,
                      //       ImageSource.camera,
                      //     );

                      //     if (mounted) {
                      //       setState(() {
                      //         isCameraLoading = true;
                      //       });
                      //     }

                      //     if (image == null) {
                      //       _controller.validate();
                      //     } else if (image != null) {
                      //       if (mounted) {
                      //         setState(() {
                      //           isCameraLoading = false;
                      //           buttonCameraColor = ThemeColors.green;
                      //           buttonCameraIcon = const Icon(Icons.check);
                      //           buttonCameraSelected = true;
                      //           isCameraSelected = true;
                      //         });
                      //       }
                      //     }
                      //   }
                      // },
                      icon: isCameraLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : buttonCameraIcon,
                      label: const Text('Cámara'),
                    ),
                  ),
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
              focusNode: focusNode,
              textInputAction: TextInputAction.none,
              hint: 'Respuesta',
              controller: widget.controller,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectImageFromGallery() async {
    if (mounted) {
      setState(() {
        isFileLoading = true;
      });
    }

    final image = await _controller.pickImage(
      CustomStep.images,
      ImageSource.gallery,
    );

    if (mounted) {
      if (image != null) {
        setState(() {
          isFileLoading = false;
          buttonFileColor = ThemeColors.green;
          buttonFileIcon = const Icon(Icons.check);
          buttonFileSelected = true;
          isFileSelected = true;
        });
      } else {
        setState(() {
          isFileLoading = false;
        });
      }
    }
  }

  Future<void> selectImageFromCamera() async {
    if (mounted) {
      setState(() {
        isCameraLoading = true;
      });
    }

    final image = await _controller.pickImage(
      CustomStep.images,
      ImageSource.camera,
    );

    if (mounted) {
      if (image != null) {
        setState(() {
          isCameraLoading = false;
          buttonCameraColor = ThemeColors.green;
          buttonCameraIcon = const Icon(Icons.check);
          buttonCameraSelected = true;
          isFileSelected = true;
        });
      } else {
        setState(() {
          isCameraLoading = false;
        });
      }
    }
  }
}
