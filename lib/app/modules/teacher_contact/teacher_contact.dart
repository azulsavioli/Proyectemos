import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

import '../../../utils/get_user.dart';
import '../widgets/custom_text_form_field.dart';
import 'teacher_controller.dart';

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
  late FocusNode focusNode1;
  late FocusNode focusNode2;

  @override
  void initState() {
    super.initState();

    setState(() {
      focusNode1 = FocusNode();
      focusNode2 = FocusNode();
    });
  }

  @override
  void dispose() {
    setState(() {
      focusNode1.dispose();
      focusNode2.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = TeacherController(context);

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
              focusNode: focusNode1,
              hint: 'Assunto',
              controller: _assuntoController,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNode1,
              hint: 'Mensaje',
              controller: _descricaoController,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 10 caracteres',
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

                  _controller.sendEmail(
                    currentUser!,
                    _assuntoController.text,
                    _descricaoController.text,
                  );
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
