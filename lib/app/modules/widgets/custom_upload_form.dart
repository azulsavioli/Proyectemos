import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import 'custom_text_form_field.dart';

class CustomUploadForm extends StatefulWidget {
  final String title;
  final TextEditingController controller;

  const CustomUploadForm({
    super.key,
    required this.title,
    required this.controller,
  });

  static List<PlatformFile> listFiles = [];

  @override
  State<CustomUploadForm> createState() => _CustomUploadFormState();
}

class _CustomUploadFormState extends State<CustomUploadForm> {
  bool buttonFileSelected = false;
  bool isButtonDisabled = false;
  Icon buttonFileIcon = const Icon(
    Icons.file_copy,
    color: ThemeColors.white,
  );
  Color buttonFileColor = ThemeColors.blue;

  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlatformFile? pickedFile;

    Future selectFile(List<PlatformFile> listFiles) async {
      final fileSelected = await FilePicker.platform.pickFiles();
      if (fileSelected == null) return;
      if (mounted) {
        setState(() {
          pickedFile = fileSelected.files.first;
          buttonFileColor = ThemeColors.green;
          buttonFileIcon = const Icon(
            Icons.check,
            color: ThemeColors.white,
          );
          buttonFileSelected = true;
        });
      }
      listFiles.add(pickedFile!);
      return pickedFile;
    }

    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          widget.title,
          style: ThemeText.paragraph16GrayBold,
        ),
        const SizedBox(
          height: 25,
        ),
        CustomTextFormField(
          focusNode: focusNode,
          textInputAction: TextInputAction.go,
          hint: 'Nombre del artista',
          controller: widget.controller,
          keyboardType: TextInputType.text,
          validatorVazio: 'Ingrese tuja respuesta correctamente',
          validatorMenorqueNumero:
              'Su respuesta debe tener al menos 3 caracteres',
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            icon: buttonFileIcon,
            onPressed: () {
              selectFile(CustomUploadForm.listFiles);
              if (mounted) {
                setState(() {
                  if (pickedFile == null) {
                    isButtonDisabled = false;
                  } else {
                    isButtonDisabled = true;
                  }
                });
              }
            },
            label: Text(
              'Subir el archivo',
              style: ThemeText.paragraph16White,
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
