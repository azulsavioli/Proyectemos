import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings_latinoamerica.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../commons/google_sign_in.dart';
import '../../../../commons/strings.dart';
import '../../../../utils/email_sender.dart';
import '../../../../utils/latinoamerica_pdf/latinoamerica_pdf.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/step.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PUnoLatinoamericaTareaTresPage extends StatefulWidget {
  const PUnoLatinoamericaTareaTresPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaTresPage> createState() =>
      PUnoLatinoamericaTareaTresPageState();
}

class PUnoLatinoamericaTareaTresPageState
    extends State<PUnoLatinoamericaTareaTresPage> {
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
  final formKey = GlobalKey<FormState>();

  List<XFile> selectedImages = CustomStep.images;

  List<String> setImages() {
    List<String> imgPaths = [];
    for (var img in selectedImages) {
      imgPaths.add(img.path);
    }
    return imgPaths;
  }

  Future convertImageToFirebase(imgPaths, currentUser) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = await currentUser.email;

    var counter = 0;

    try {
      for (var img in imgPaths) {
        if (imgPaths == null) return;
        var file = File(img);
        counter++;

        var snapshot = await firebaseStorage
            .ref()
            .child('uno-latinoamerica-images/$email-img-$counter.jpeg')
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert image: ${e.toString()}';
    }
  }

  setJson(imagesList) {
    final json = {
      'resposta_1': [answerUnoController.text, imagesList[0]],
      'resposta_2': [answerDosController.text, imagesList[1]],
      'resposta_3': [answerTresController.text, imagesList[2]],
      'resposta_4': [answerQuatroController.text, imagesList[3]],
      'resposta_5': [answerCincoController.text, imagesList[4]],
      'resposta_6': [answerSeisController.text, imagesList[5]],
      'resposta_7': [answerSieteController.text, imagesList[6]],
      'resposta_8': [answerOchoController.text, imagesList[7]],
      'resposta_9': [answerNueveController.text, imagesList[8]],
      'resposta_10': [answerDiezController.text, imagesList[9]],
    };
    return json;
  }

  Future<dynamic> makeJson(currentUser) async {
    var list = setImages();
    var firebasePaths = await convertImageToFirebase(list, currentUser);
    var json = setJson(firebasePaths);
    return json;
  }

  sendAnswers(currentUser) async {
    var json = await makeJson(currentUser);
    String doc = 'uno/latinoamerica/atividade_3/';

    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<void> sendEmail(context, currentUser) async {
    final pdfMaker = LatinoamericaPdf(context);
    final attachment = [FileAttachment(await pdfMaker.createPDF())];
    const email = [
      'comesana.alexis.silvera@gmail.com',
      'fernandamaiadeoliveira@gmail.com'
    ];
    const subject = "Atividade Latinoamerica";
    const text = "Atividade Latinoamerica concluída!";
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
        currentUser, attachment, email, subject, text);
  }

  List<Step> steps(
      controllerUno,
      controllerDos,
      controllerTres,
      controllerQuatro,
      controllerCinco,
      controllerSeis,
      controllerSiete,
      controllerOcho,
      controllerNueve,
      controllerDiez) {
    return [
      const Step(
        title: Text(
          StringsLationamerica.titleQOnePageTresLatin,
          style: ThemeText.h3title22BlueNormal,
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
          title: "Primera imagen",
          stepIndex: 1,
          currentStep: 1,
          controller: controllerUno,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 2'),
        content: CustomStep(
          title: "Segunda imagen",
          stepIndex: 2,
          currentStep: 2,
          controller: controllerDos,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 3'),
        content: CustomStep(
          title: "Tercera imagen",
          stepIndex: 3,
          currentStep: 3,
          controller: controllerTres,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 4'),
        content: CustomStep(
          title: "Cuarta imagen",
          stepIndex: 4,
          currentStep: 4,
          controller: controllerQuatro,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 5'),
        content: CustomStep(
          title: "Quinta imagen",
          stepIndex: 5,
          currentStep: 5,
          controller: controllerCinco,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 6'),
        content: CustomStep(
          title: "Sesta imagen",
          stepIndex: 6,
          currentStep: 6,
          controller: controllerSeis,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 7'),
        content: CustomStep(
          title: "Septima imagen",
          stepIndex: 7,
          currentStep: 7,
          controller: controllerSiete,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 8'),
        content: CustomStep(
          title: "Ochava imagen",
          stepIndex: 8,
          currentStep: 8,
          controller: controllerOcho,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 9'),
        content: CustomStep(
          title: "Nuena imagen",
          stepIndex: 9,
          currentStep: 9,
          controller: controllerNueve,
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Etapa 10'),
        content: CustomStep(
          title: "Decima imagen",
          stepIndex: 10,
          currentStep: 10,
          controller: controllerDiez,
        ),
        isActive: true,
      ),
    ];
  }

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

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
      body: Form(
        key: formKey,
        child: Stepper(
            currentStep: currentStep,
            steps: steps(
                answerUnoController,
                answerDosController,
                answerTresController,
                answerQuatroController,
                answerCincoController,
                answerSeisController,
                answerSieteController,
                answerOchoController,
                answerNueveController,
                answerDiezController),
            onStepContinue: () {
              final isLastStep = currentStep == 10;

              if (currentStep < 11 - 1) {
                setState(() => currentStep++);
              }

              if (isLastStep) {
                if (formKey.currentState!.validate() &&
                    selectedImages.length == 10) {
                  sendAnswers(currentUser);
                  sendEmail(context, currentUser);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(Strings.tareaConcluida),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.pushNamed(context, '/proyecto_uno');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Selecciona una imagen de su cámara o de su archivo y escriba su descripción',
                    ),
                    duration: Duration(seconds: 2),
                  ));
                }
              }
            },
            onStepTapped: (step) {
              setState(() {
                currentStep = step;
              });
            },
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() => currentStep--);
              }
              currentStep == 0 ? null : () => setState(() => currentStep--);
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == 10;
              return Row(
                children: <Widget>[
                  if (currentStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.white),
                        ),
                        onPressed: details.onStepCancel,
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: ThemeColors.blue),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(isLastStep ? 'Concluir' : 'Continuar'),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  GoogleSignInAccount? getCurrentUser(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    var currentUser = provider.googleSignIn.currentUser;

    if (currentUser == null) {
      provider.googleSignIn.signInSilently();
      provider.googleLogin();
      currentUser = provider.googleSignIn.currentUser;
    } else if (currentUser.authentication == null) {
      provider.googleLogout();
      provider.googleSignIn.signInSilently();
      provider.googleLogin();
    }
    return currentUser;
  }
}
