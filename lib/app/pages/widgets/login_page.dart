import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/pages/services/auth_services.dart';
import 'package:proyectemos/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        titulo = '¡Proyectemos!';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao login';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'Email',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o email corretamente';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'Senha',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe sua senha!';
                            } else if (value.length < 6) {
                              return 'Sua senha deve possuir no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: ElevatedButton(
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
                                    const Icon(Icons.check),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        actionButton,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                onPrimary: Colors.black,
                                minimumSize: const Size(double.infinity, 50)),
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final provider = Provider.of<GoogleSignnProvider>(
                                  context,
                                  listen: false);
                              provider.googleLogin();
                            },
                            label: const Text('Login com sua conta Google',
                                style: TextStyle(color: Colors.white))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: TextButton(
                            onPressed: () => setFormAction(!isLogin),
                            child: Text(
                              toggleButton,
                              style: const TextStyle(color: Colors.blueGrey),
                            )),
                      )
                    ]),
              ))),
    );
  }
}
