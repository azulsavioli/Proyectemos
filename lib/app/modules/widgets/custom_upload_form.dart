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
  bool _isButtonDisabled = false;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;

  @override
  Widget build(BuildContext context) {
    PlatformFile? pickedFile;

    Future selectFile(List<PlatformFile> listFiles) async {
      final fileSelected = await FilePicker.platform.pickFiles();
      if (fileSelected == null) return;

      setState(() {
        pickedFile = fileSelected.files.first;
        buttonFileColor = ThemeColors.green;
        buttonFileIcon = const Icon(Icons.check);
        buttonFileSelected = true;
      });

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
              setState(() {
                if (pickedFile == null) {
                  _isButtonDisabled = false;
                } else {
                  _isButtonDisabled = true;
                }
              });
            },
            label: const Text(
              'Subir el archivo',
              style: ThemeText.paragraph16White,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          hint: 'Nombre del artista',
          controller: widget.controller,
          keyboardType: TextInputType.text,
          validatorVazio: 'Ingrese tuja respuesta correctamente',
          validatorMenorque10: 'Su respuesta debe tener al menos 10 caracteres',
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
