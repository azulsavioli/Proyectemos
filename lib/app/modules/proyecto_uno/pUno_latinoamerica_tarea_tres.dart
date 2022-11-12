import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:provider/provider.dart';
import 'package:proyectemos/app/services/storage_service.dart';
import '../../../commons/google_sign_in.dart';
import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../../../utils/pdf_maker.dart';
import '../../proyectemos_repository.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/drawer_menu.dart';

class PUnoLatinoamericaTareaTresPage extends StatefulWidget {
  const PUnoLatinoamericaTareaTresPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaTresPage> createState() =>
      _PUnoLatinoamericaTareaTresPageState();
}

class _PUnoLatinoamericaTareaTresPageState
    extends State<PUnoLatinoamericaTareaTresPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final StorageService storageService = StorageService();

  final formKey = GlobalKey<FormState>();

  final answerUnoController = TextEditingController();
  final answerDosController = TextEditingController();
  final answerTresController = TextEditingController();
  final answerQuatroController = TextEditingController();
  final answerCincoController = TextEditingController();
  final answerSeisController = TextEditingController();
  final answerSieteController = TextEditingController();
  final answerOchoController = TextEditingController();
  final answerNueveController = TextEditingController();
  final answerDiezController = TextEditingController();

  String choosedUnoImage = '';
  String choosedDosImage = '';
  String choosedTresImage = '';
  String choosedQuatroImage = '';
  String choosedCincoImage = '';
  String choosedSeisImage = '';
  String choosedSieteImage = '';
  String choosedOchoImage = '';
  String choosedNueveImage = '';
  String choosedDiezImage = '';

  bool loading = false;
  int currentStep = 0;
  late GoogleSignInAccount user;

  final Map<String, Map<String, List>> answerList = {};

  @override
  Widget build(BuildContext context) {
    PdfMaker pdfMaker = PdfMaker(context);

    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        automaticallyImplyLeading: true,
        title: const Text(Strings.titleLatinoamericaUno,
            style: ThemeText.paragraph16WhiteBold),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'Descargar mis imágenes',
                  style: ThemeText.h3title22BlueNormal,
                ),
                Stepper(
                    currentStep: currentStep,
                    onStepCancel: () {
                      if (currentStep > 0) {
                        setState(() => currentStep -= 1);
                      }
                      currentStep == 0
                          ? null
                          : () => setState(() => currentStep -= 1);
                    },
                    onStepContinue: () {
                      final isLastStep = currentStep == getSteps.length - 1;
                      if (currentStep < 10 - 1) {
                        setState(() => currentStep += 1);
                      }
                      if (isLastStep) {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        var currentUser = provider.googleSignIn.currentUser;

                        if (currentUser == null) {
                          provider.googleSignIn.signIn();
                          currentUser = provider.googleSignIn.currentUser;
                        }

                        sendAnswersToFirebase(answerList);
                        sendEmailToTeacher(currentUser);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Tarea concluída com sucesso!")));
                        Navigator.pushNamed(context, '/proyecto_uno');
                      }
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        currentStep = index;
                      });
                    },
                    steps: getSteps,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      final isLastStep = currentStep == getSteps.length - 1;

                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(isLastStep ? 'Concluir' : 'Continua'),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: const Text('Cancelar'),
                              ),
                            ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Step> get getSteps {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text('Primera imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual la descripción de esa imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerUnoController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedUnoImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedUnoImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Segunda imagen'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cual a descricion desta imagen',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'Respuesta',
                  controller: answerDosController,
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorque10:
                      'Su respuesta debe tener al menos 10 caracteres',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.gallery, choosedDosImage),
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Galería')),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.yellow),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.camera, choosedDosImage),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Cámara')),
                  ],
                ),
              ],
            ),
          )),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Tercera imagen'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cual a descricion desta imagen',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'Respuesta',
                  controller: answerTresController,
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorque10:
                      'Su respuesta debe tener al menos 10 caracteres',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.gallery, choosedTresImage),
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Galería')),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.yellow),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.camera, choosedTresImage),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Cámara')),
                  ],
                ),
              ],
            ),
          )),
      Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text('Cuarta imagen'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cual a descricion desta imagen',
                  style: ThemeText.paragraph14Gray,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'Respuesta',
                  controller: answerQuatroController,
                  keyboardType: TextInputType.text,
                  validatorVazio: 'Ingrese tuja respuesta correctamente',
                  validatorMenorque10:
                      'Su respuesta debe tener al menos 10 caracteres',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.gallery, choosedQuatroImage),
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Galería')),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.yellow),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            pickImage(ImageSource.camera, choosedQuatroImage),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Cámara')),
                  ],
                ),
              ],
            ),
          )),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text('Quinta imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerCincoController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedCincoImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedCincoImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text('Sesta imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerSeisController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedSeisImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedSeisImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 6,
        title: const Text('Septima imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerSieteController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedSieteImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedSieteImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 7 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 7,
        title: const Text('Ochava imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerOchoController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedOchoImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedOchoImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 8 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 8,
        title: const Text('Nuena imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerNueveController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedNueveImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedNueveImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 9 ? StepState.complete : StepState.indexed,
        isActive: currentStep == 9,
        title: const Text('Decima imagen'),
        content: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cual a descricion desta imagen',
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Respuesta',
                controller: answerDiezController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorque10:
                    'Su respuesta debe tener al menos 10 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.gallery, choosedDiezImage),
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Galería')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () =>
                          pickImage(ImageSource.camera, choosedDiezImage),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Cámara')),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Future pickImage(ImageSource source, choosedImage) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      final firebaseStorage = FirebaseStorage.instance;
      if (image == null) return;
      var file = File(image.path);

      var snapshot = await firebaseStorage
          .ref()
          .child('images/imageName')
          .putFile(file)
          .whenComplete(() => null);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        if (choosedImage == choosedUnoImage) {
          choosedUnoImage = downloadUrl;
        } else if (choosedImage == choosedDosImage) {
          choosedDosImage = downloadUrl;
        } else if (choosedImage == choosedTresImage) {
          choosedTresImage = downloadUrl;
        } else if (choosedImage == choosedQuatroImage) {
          choosedQuatroImage = downloadUrl;
        } else if (choosedImage == choosedCincoImage) {
          choosedCincoImage = downloadUrl;
        } else if (choosedImage == choosedSeisImage) {
          choosedSeisImage = downloadUrl;
        } else if (choosedImage == choosedSieteImage) {
          choosedSieteImage = downloadUrl;
        } else if (choosedImage == choosedOchoImage) {
          choosedOchoImage = downloadUrl;
        } else if (choosedImage == choosedNueveImage) {
          choosedNueveImage = downloadUrl;
        } else if (choosedImage == choosedDiezImage) {
          choosedDiezImage = downloadUrl;
        }
        choosedImage = downloadUrl;
      });
    } on PlatformException catch (e) {
      print('Failed to pick an image: $e');
    }
  }

  setImages() {
    answerList.addAll(
      {
        'answer_imagens': {
          'resposta_1': [answerUnoController.text, choosedUnoImage],
          'resposta_2': [answerDosController.text, choosedDosImage],
          'resposta_3': [answerTresController.text, choosedTresImage],
          'resposta_4': [answerQuatroController.text, choosedQuatroImage],
          'resposta_5': [answerCincoController.text, choosedCincoImage],
          'resposta_6': [answerSeisController.text, choosedSeisImage],
          'resposta_7': [answerSieteController.text, choosedSieteImage],
          'resposta_8': [answerOchoController.text, choosedOchoImage],
          'resposta_9': [answerNueveController.text, choosedNueveImage],
          'resposta_10': [answerDiezController.text, choosedDiezImage],
        }
      },
    );
  }

  void sendAnswersToFirebase(answerList) async {
    setImages();

    String doc = 'uno/latinoamerica/atividade_3/';
    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, answerList);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Resposta enviada com sucesso!")));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future sendEmailToTeacher(currentUser) async {
    final pdfMaker = PdfMaker(context);
    final pdf = await pdfMaker.createPDF();

    var email = currentUser.email;
    var userName = currentUser.displayName;

    final auth = await currentUser.authentication;
    final token = auth.accessToken!;
    final smtpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..attachments = [FileAttachment(pdf)]
      ..from = Address(email, userName)
      ..recipients = [email]
      ..subject = "Maia de olivera"
      ..text = "teste email 4! bora vee ";

    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      print(e);
    }
  }
}
