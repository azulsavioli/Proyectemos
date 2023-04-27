import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../commons/styles.dart';
import '../../../utils/email_sender.dart';
import '../../../utils/get_user.dart';
import '../../proyectemos_repository.dart';
import '../widgets/custom_text_form_field.dart';

class EnvioEmailProfesoraPerfil extends StatefulWidget {
  const EnvioEmailProfesoraPerfil({super.key});

  @override
  State<EnvioEmailProfesoraPerfil> createState() =>
      _EnvioEmailProfesoraPerfilState();
}

class _EnvioEmailProfesoraPerfilState extends State<EnvioEmailProfesoraPerfil> {
  final formKey = GlobalKey<FormState>();
  final _assuntoController = TextEditingController();
  final _descricaoController = TextEditingController();

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

  Future<void> sendEmail(GoogleSignInAccount currentUser) async {
    final email = await getEmailTeacherFromFirebase();

    final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    final subject = _assuntoController.text;
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
${_descricaoController.text}''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      [],
      [email.first.values.first],
      subject,
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Contacto con la profesora',
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enviar un email a profesora',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: 'Assunto',
              controller: _assuntoController,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 10 caracteres',
              validatorNumeroDeCaracteres: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: 'Mensaje',
              controller: _descricaoController,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 10 caracteres',
              validatorNumeroDeCaracteres: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ThemeColors.yellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  final currentUser = getCurrentUser(context);

                  sendEmail(currentUser!);
                  Navigator.pushNamed(
                    context,
                    '/pUno_evento_cultural_feedback',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Enviar el email ',
                        style:
                            TextStyle(fontSize: 20, color: ThemeColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
