import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings_latinoamerica.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commons/strings.dart';
import '../../../../../repository/proyectemos_repository.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/email_sender.dart';
import '../../../../../utils/get_user.dart';
import '../../../widgets/drawer_menu.dart';
import '../../../widgets/step.dart';

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
  bool latinoamerica = false;

  List<XFile> selectedImages = CustomStep.images;

  List<String> setImages() {
    final imgPaths = <String>[];

    for (final img in selectedImages) {
      imgPaths.add(img.path);
    }
    return imgPaths;
  }

  Future convertImageToFirebase(
    List<String> imgPaths,
    GoogleSignInAccount? currentUser,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = currentUser?.email;

    var counter = 0;

    try {
      for (final img in imgPaths) {
        if (imgPaths.isEmpty) return;
        final file = File(img);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child('uno-latinoamerica-images/$email-img-$counter.jpeg')
            .putFile(file)
            .whenComplete(() => null);

        final downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert image: ${e.message}';
    }
  }

  Map<String, Object> setJson(List<dynamic> imagesList) {
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

  Map<String, Object> setJsonForFirebase(List<dynamic> imagesList) {
    final user = getCurrentUser(context);
    final json = {
      'nome': '${user?.displayName}',
      'imagem_latinoamerica_1': [answerUnoController.text, imagesList[0]],
      'imagem_latinoamerica_2': [answerDosController.text, imagesList[1]],
      'imagem_latinoamerica_3': [answerTresController.text, imagesList[2]],
      'imagem_latinoamerica_4': [answerQuatroController.text, imagesList[3]],
      'imagem_latinoamerica_5': [answerCincoController.text, imagesList[4]],
      'imagem_latinoamerica_6': [answerSeisController.text, imagesList[5]],
      'imagem_latinoamerica_7': [answerSieteController.text, imagesList[6]],
      'imagem_latinoamerica_8': [answerOchoController.text, imagesList[7]],
      'imagem_latinoamerica_9': [answerNueveController.text, imagesList[8]],
      'imagem_latinoamerica_10': [answerDiezController.text, imagesList[9]]
    };
    return json;
  }

  Future makeJson(GoogleSignInAccount? currentUser) async {
    final list = setImages();
    final firebasePaths = await convertImageToFirebase(list, currentUser);
    final json = setJson(firebasePaths);
    return json;
  }

  Future makeJsonImages(GoogleSignInAccount? currentUser) async {
    final list = setImages();
    final firebasePaths = await convertImageToFirebase(list, currentUser);
    final json = setJsonForFirebase(firebasePaths);
    return json;
  }

  Future<dynamic> sendAnswers(GoogleSignInAccount? currentUser) async {
    final json = await makeJson(currentUser);
    final jsonImages = await makeJsonImages(currentUser);
    const doc = 'uno/latinoamerica/atividade_3/';

    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
      await context.read<ProyectemosRepository>().saveImagesTurma(jsonImages);
      await Future.delayed(
        const Duration(seconds: 10),
        () => sendEmail(context, currentUser),
      );
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> getEmailTeacherFromFirebase() async {
    final emails = [];
    const doc = 'professora';
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getTeacherEmail(doc);
      emails.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return emails;
  }

  Future<void> sendEmail(
    BuildContext context,
    GoogleSignInAccount? currentUser,
  ) async {
    final attachment = setupAttachments();
    final email = await getEmailTeacherFromFirebase();

    final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    const subject = 'Atividade - Latinoamerica\n Tarea Tres';
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Série: ${allStudentInfo[2]} - Turma: ${allStudentInfo[3]}\n\n 
Atividade Latinoamerica 3ª tarefa concluída!
\n
     Descrição Imagem 1: ${answerUnoController.text}
     Descrição Imagem 2: ${answerDosController.text}
     Descrição Imagem 3: ${answerTresController.text}
     Descrição Imagem 4: ${answerQuatroController.text}
     Descrição Imagem 5: ${answerCincoController.text} 
     Descrição Imagem 6: ${answerSeisController.text}
     Descrição Imagem 7: ${answerSieteController.text}
     Descrição Imagem 8: ${answerOchoController.text}
     Descrição Imagem 9: ${answerNueveController.text}
     Descrição Imagem 10: ${answerDiezController.text}
\n
Imagens em anexo!
''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      attachment,
      [email.first.values.first],
      subject,
      text,
    );
  }

  List<FileAttachment> setupAttachments() {
    final imagesList = setImages();
    final fileOne = File(imagesList[0]);
    final fileTwo = File(imagesList[1]);
    final fileThree = File(imagesList[2]);
    final fileFour = File(imagesList[3]);
    final fileFive = File(imagesList[4]);
    final fileSix = File(imagesList[5]);
    final fileSeven = File(imagesList[6]);
    final fileEight = File(imagesList[7]);
    final fileNine = File(imagesList[8]);
    final fileTen = File(imagesList[9]);

    final attachment = [
      FileAttachment(
        fileOne,
        fileName: 'Descrição Imagem 1: ${answerUnoController.text}',
      ),
      FileAttachment(
        fileTwo,
        fileName: 'Descrição Imagem 2: ${answerDosController.text}',
      ),
      FileAttachment(
        fileThree,
        fileName: 'Descrição Imagem 3: ${answerTresController.text}',
      ),
      FileAttachment(
        fileFour,
        fileName: 'Descrição Imagem 4: ${answerQuatroController.text}',
      ),
      FileAttachment(
        fileFive,
        fileName: 'Descrição Imagem 5: ${answerCincoController.text}',
      ),
      FileAttachment(
        fileSix,
        fileName: 'Descrição Imagem 6: ${answerSeisController.text}',
      ),
      FileAttachment(
        fileSeven,
        fileName: 'Descrição Imagem 7: ${answerSieteController.text}',
      ),
      FileAttachment(
        fileEight,
        fileName: 'Descrição Imagem 8: ${answerOchoController.text}',
      ),
      FileAttachment(
        fileNine,
        fileName: 'Descrição Imagem 9: ${answerNueveController.text}',
      ),
      FileAttachment(
        fileTen,
        fileName: 'Descrição Imagem 10: ${answerDiezController.text}',
      ),
    ];
    return attachment;
  }

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
        title: Text(
          Strings.titleLatinoamericaUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
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
            answerDiezController,
          ),
          onStepContinue: () {
            final isLastStep = currentStep == 10;

            if (currentStep < 11 - 1) {
              setState(() => currentStep++);
            }

            if (isLastStep) {
              if (formKey.currentState!.validate() &&
                  selectedImages.length == 10) {
                sendAnswers(currentUser);
                showToast(Strings.tareaConcluida);
                latinoamerica = true;
                saveLatinoamericaCompleted();
                Navigator.pushNamed(
                  context,
                  '/pUno_latinoamerica_menu',
                );
              } else {
                showToast(
                  '''Selecciona una imagen de su cámara o de su archivo y escriba su descripción''',
                  color: ThemeColors.red,
                  textColor: ThemeColors.white,
                );
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
            if (currentStep == 0) {
              return;
            } else {
              setState(() => currentStep--);
            }
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
          },
        ),
      ),
    );
  }

  Future<void> saveLatinoamericaCompleted() async {
    const latinoamericaTareaTresCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      'latinoamericaTareaTresCompleted',
      latinoamericaTareaTresCompleted,
    );
  }
}
