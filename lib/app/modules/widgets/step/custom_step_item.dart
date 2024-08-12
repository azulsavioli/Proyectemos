import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commons/styles.dart';
import '../custom_text_form_field.dart';
import 'step_controller.dart';

class CustomStepInheritedWidget extends InheritedWidget {
  final bool buttonFileSelected;
  final Icon buttonFileIcon;
  final Color buttonFileColor;

  const CustomStepInheritedWidget({
    Key? key,
    required Widget child,
    required this.buttonFileSelected,
    required this.buttonFileIcon,
    required this.buttonFileColor,
  }) : super(key: key, child: child);

  static CustomStepInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CustomStepInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CustomStepInheritedWidget oldWidget) {
    return buttonFileSelected != oldWidget.buttonFileSelected ||
        buttonFileIcon != oldWidget.buttonFileIcon ||
        buttonFileColor != oldWidget.buttonFileColor;
  }
}

class CustomStep extends StatefulWidget {
  final TextEditingController controller;

  const CustomStep({
    Key? key,
    required this.controller,
  }) : super(key: key);

  static List<XFile> images = [];

  @override
  State<CustomStep> createState() => _CustomStepState();
}

class _CustomStepState extends State<CustomStep> {
  bool buttonFileSelected = false;
  bool buttonCameraSelected = false;
  Icon buttonFileIcon = const Icon(
    Icons.image_outlined,
    color: ThemeColors.white,
  );

  Color buttonFileColor = ThemeColors.red;
  final _controller = StepController();
  late FocusNode focusNode;
  bool isFileLoading = false;
  bool isFileSelected = false;

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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return CustomStepInheritedWidget(
      buttonFileSelected: buttonFileSelected,
      buttonFileIcon: buttonFileIcon,
      buttonFileColor: buttonFileColor,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleciona una imagen de su camara o de su arquivo',
              style: isMobile
                  ? ThemeText.paragraph16GrayNormal
                  : ThemeText.paragraph12Gray,
            ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, isMobile ? 50 : 80),
                      backgroundColor: ThemeColors.red,
                    ),
                    onPressed: () async {
                      setState(() {
                        selectImageFromGallery();
                      });
                    },
                    icon: isFileLoading
                        ? SizedBox(
                            width: isMobile ? 20 : 50,
                            height: isMobile ? 20 : 50,
                            child: CircularProgressIndicator(
                              color: ThemeColors.blue,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : buttonFileIcon,
                    label: Text(
                      'Galería',
                      style: isMobile
                          ? TextStyle(color: ThemeColors.white)
                          : TextStyle(
                              color: ThemeColors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: isMobile ? 20 : 30,
                ),
              ],
            ),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            const Divider(),
            SizedBox(
              height: isMobile ? 10 : 20,
            ),
            Text(
              'Cual la descripción de esa imagen',
              style: isMobile
                  ? ThemeText.paragraph16GrayNormal
                  : ThemeText.paragraph12Gray,
            ),
            SizedBox(
              height: isMobile ? 20 : 30,
            ),
            CustomTextFormField(
              focusNode: focusNode,
              textInputAction: TextInputAction.next,
              hint: 'Respuesta',
              controller: widget.controller,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            SizedBox(
              height: isMobile ? 30 : 30,
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
          buttonFileIcon = const Icon(
            Icons.check,
            color: ThemeColors.white,
          );
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
}
