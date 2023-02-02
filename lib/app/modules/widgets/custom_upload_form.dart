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
  @override
  Widget build(BuildContext context) {
    PlatformFile? pickedFile;
    bool loading = false;

    Future selectFile(List<PlatformFile> listFiles) async {
      final fileSelected = await FilePicker.platform.pickFiles();
      if (fileSelected == null) return;

      setState(() {
        pickedFile = fileSelected.files.first;
      });

      listFiles.add(pickedFile!);
      return pickedFile;
    }

    return Column(children: [
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
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                _isButtonDisabled ? ThemeColors.green : ThemeColors.blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {
            loading = true;
            selectFile(CustomUploadForm.listFiles);
            setState(() {
              if (pickedFile == null) {
                _isButtonDisabled = false;
              } else {
                _isButtonDisabled = true;
              }
            });
            loading = false;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (loading)
                ? [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]
                : [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Subir el archivo",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
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
    ]);
  }
}
