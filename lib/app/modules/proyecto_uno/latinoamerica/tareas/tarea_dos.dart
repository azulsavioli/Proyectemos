import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/proyectemos_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../commons/strings.dart';
import '../../../../../commons/strings_latinoamerica.dart';
import '../../../../../commons/styles.dart';
import '../../../../../services/toast_services.dart';
import '../../../../../utils/email_sender.dart';
import '../../../../../utils/get_user.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/drawer_menu.dart';

class PUnoLatinoamericaTareaDosPage extends StatefulWidget {
  const PUnoLatinoamericaTareaDosPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaDosPage> createState() =>
      _PUnoLatinoamericaTareaDosPageState();
}

class _PUnoLatinoamericaTareaDosPageState
    extends State<PUnoLatinoamericaTareaDosPage> {
  final formKey = GlobalKey<FormState>();
  final _answerUnoController = TextEditingController();
  final _answerDosController = TextEditingController();
  final _answerTresController = TextEditingController();

  bool loading = false;

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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsLationamerica.qOneLationPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerUnoController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorqueNumero:
                          'Su respuesta debe tener al menos 10 caracteres',
                      validatorNumeroDeCaracteres: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      StringsLationamerica.qTwoLatinPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerDosController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorqueNumero:
                          'Su respuesta debe tener al menos 10 caracteres',
                      validatorNumeroDeCaracteres: 10,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      StringsLationamerica.qThreeLatinPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerTresController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorqueNumero:
                          'Su respuesta debe tener al menos 10 caracteres',
                      validatorNumeroDeCaracteres: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      StringsLationamerica.titleQOnePageDosLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final json = {
                              'resposta_1': _answerUnoController.text,
                              'resposta_2': _answerDosController.text,
                              'resposta_3': _answerTresController.text,
                            };
                            final respostas = [
                              _answerUnoController.text,
                              _answerDosController.text,
                              _answerTresController.text,
                            ];
                            sendAnswersToFirebase(json);
                            sendEmail(currentUser, respostas);
                            showToast(Strings.tareaConcluida);

                            saveLatinoamericaCompleted();

                            Navigator.pushNamed(
                              context,
                              '/pUno_latinoamerica_menu',
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: loading
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
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Contínua',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios),
                                ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendAnswersToFirebase(Map<String, String> json) async {
    const doc = 'uno/latinoamerica/atividade_2/';
    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> saveLatinoamericaCompleted() async {
    const latinoamericaTareaDosCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      'latinoamericaTareaDosCompleted',
      latinoamericaTareaDosCompleted,
    );
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

  Future<void> sendEmail(currentUser, respostas) async {
    final email = await getEmailTeacherFromFirebase();

    final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    const subject = 'Atividade - Latinoamerica\n Tarea Dos';
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
Atividade Latinoamerica 2ª tarefa concluída!
\n\n
Pergunta: ${StringsLationamerica.qOneLationPageTwo}\n
Resposta: ${respostas[0]}
\n
Pergunta: ${StringsLationamerica.qTwoLatinPageTwo}\n
Resposta: ${respostas[1]}
\n
Pergunta: ${StringsLationamerica.qThreeLatinPageTwo}\n
Resposta: ${respostas[2]}
''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      [],
      [email.first.values.first],
      subject,
      text,
    );
  }
}
