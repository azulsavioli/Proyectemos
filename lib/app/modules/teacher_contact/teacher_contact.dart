import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

import '../../../utils/get_user.dart';
import '../widgets/custom_text_form_field.dart';
import 'teacher_controller.dart';

// class EnvioEmailProfesoraPerfil extends StatefulWidget {
//   const EnvioEmailProfesoraPerfil({super.key});

//   @override
//   State<EnvioEmailProfesoraPerfil> createState() =>
//       _EnvioEmailProfesoraPerfilState();
// }

// class _EnvioEmailProfesoraPerfilState extends State<EnvioEmailProfesoraPerfil> {
//   final formKey = GlobalKey<FormState>();
//   final _assuntoController = TextEditingController();
//   final _descricaoController = TextEditingController();
//   late FocusNode focusNode1;
//   late FocusNode focusNode2;

//   @override
//   void initState() {
//     super.initState();

//     if (mounted) {
//       setState(() {
//         focusNode1 = FocusNode();
//         focusNode2 = FocusNode();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     if (mounted) {
//       setState(() {
//         focusNode1.dispose();
//         focusNode2.dispose();
//       });
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _controller = TeacherController(context);
//     final currentUser = getCurrentUser(context);

//     return SingleChildScrollView(
//       child: Scaffold(
//         backgroundColor: ThemeColors.white,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           centerTitle: true,
//           iconTheme: const IconThemeData(
//             color: Color.fromRGBO(250, 251, 250, 1),
//           ),
//           title: Text(
//             'Contacto con la profesora',
//             style: ThemeText.paragraph16WhiteBold,
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Enviar un email a profesora',
//                 style: ThemeText.paragraph16GrayNormal,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextFormField(
//                 focusNode: focusNode1,
//                 textInputAction: TextInputAction.next,
//                 hint: 'Assunto',
//                 controller: _assuntoController,
//                 keyboardType: TextInputType.text,
//                 validatorVazio: 'Ingrese tuja respuesta correctamente',
//                 validatorMenorqueNumero:
//                     'Su respuesta debe tener al menos 3 caracteres',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextFormField(
//                 focusNode: focusNode2,
//                 textInputAction: TextInputAction.done,
//                 hint: 'Mensaje',
//                 controller: _descricaoController,
//                 keyboardType: TextInputType.text,
//                 validatorVazio: 'Ingrese tuja respuesta correctamente',
//                 validatorMenorqueNumero:
//                     'Su respuesta debe tener al menos 10 caracteres',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 60,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(ThemeColors.yellow),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (mounted) {
//                       _controller.sendEmail(
//                         currentUser!,
//                         _assuntoController.text,
//                         _descricaoController.text,
//                       );
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Text(
//                           'Enviar el email ',
//                           style:
//                               TextStyle(fontSize: 20, color: ThemeColors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class EnvioEmailProfesoraPerfil extends StatefulWidget {
  const EnvioEmailProfesoraPerfil({Key? key}) : super(key: key);

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
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = TeacherController(context);
    final currentUser = getCurrentUser(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Contacto con la profesora',
          style: ThemeText.paragraph16White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enviar un email a profesora',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      focusNode: focusNode1,
                      textInputAction: TextInputAction.next,
                      hint: 'Assunto',
                      controller: _assuntoController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorqueNumero:
                          'Su respuesta debe tener al menos 3 caracteres',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      focusNode: focusNode2,
                      textInputAction: TextInputAction.done,
                      hint: 'Mensaje',
                      controller: _descricaoController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorqueNumero:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity, // Define a largura como infinita
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Theme.of(context).primaryColor),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  _controller.sendEmail(
                    currentUser!,
                    _assuntoController.text,
                    _descricaoController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Enviar el email ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
