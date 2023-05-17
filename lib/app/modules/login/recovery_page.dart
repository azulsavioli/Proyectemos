import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../services/toast_services.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  late Future<bool> result;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          backgroundColor: ThemeColors.blue,
          elevation: 0,
          title: Text(
            'Recuperar contraseña',
            style: ThemeText.paragraph16White,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    '''Reciba un correo electrónico para\nrestablecer tu contraseña''',
                    style: ThemeText.paragraph16GrayNormal,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  style: ThemeText.paragraph16GrayNormal,
                  controller: emailController,
                  cursorColor: Colors.blueGrey,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Correo electrónico',
                        style: ThemeText.paragraph16GrayLight,
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Ingrese el correo electrónico correctamente';
                    }
                    if (!email.contains('@')) {
                      return 'Ingrese un correo eletrónico valido';
                    }
                    if (email.length < 10) {
                      return '''El correo electrónico debe tener al menos 10 caracteres''';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.yellow,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      if (formKey.currentState!.validate())
                        {
                          resetPassword.call().then(
                                (value) => showToast(
                                    '''Correo electrónico de recuperación de contraseña enviado'''),
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text(
                                //       '''Correo electrónico de recuperación de contraseña enviado''',
                                //     ),
                                //   ),
                                // ),
                              ),
                          Navigator.pop(context)
                        }
                      else
                        {
                          showToast(
                              '''¡Ups! Ha ocurrido un error y su correo electrónico de recuperación de contraseña no ha sido enviado. ¡Inténtalo de nuevo!'''),
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text(
                          //       '''¡Ups! Ha ocurrido un error y su correo electrónico de recuperación de contraseña no ha sido enviado. ¡Inténtalo de nuevo!''',
                          //     ),
                          //   ),
                          // ),
                        }
                    },
                    icon: const Icon(Icons.email_outlined),
                    label: Text(
                      'Restablecer la contraseña',
                      style: ThemeText.paragraph16WhiteBold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future resetPassword() async {
    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
