import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/strings.dart';
import '../../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  late String actionButton;
  late String toggleButton;
  late IconData icon;
  bool loading = false;
  bool loadingGoogle = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        actionButton = 'Acceso';
        toggleButton = '¿Aún no tienes una cuenta? Regístrate ahora.';
        icon = Icons.lock_open_outlined;
      } else {
        actionButton = 'Crea tu cuenta';
        toggleButton = 'Atrás para iniciar sesión';
        icon = Icons.arrow_forward_ios;
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .login(emailController.text, passwordController.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(emailController.text, passwordController.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        Strings.logo,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                  child: Text(
                    '!Bienvenidos a Proyectemos!',
                    style: ThemeText.h1title45YellowBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Correo electrónico',
                        style: ThemeText.paragraph16GrayLight,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Ingrese el correo electrónico correctamente';
                    }
                    if (!email.contains('@')) {
                      return 'Ingrese un correo eletrónico valido';
                    }
                    if (email.length < 10) {
                      return 'El correo electrónico debe tener al menos 10 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Contraseña',
                        style: ThemeText.paragraph16GrayLight,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informa tu contraseña!';
                    } else if (value.length < 6) {
                      return 'Tu contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  actionButton,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Icon(icon),
                            ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/recoveryPassword');
                  },
                  child: const Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 36,
                        )),
                  ),
                  const Text("O entonces"),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 36,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      loadingGoogle = true;
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loadingGoogle)
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
                              const FaIcon(
                                FontAwesomeIcons.google,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Inicia sesión con tu cuenta de Google',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(
                    toggleButton,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
