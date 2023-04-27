import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadingGoogle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade400,
                Colors.blue.shade600,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Image.asset(
                      Strings.loginImage,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.bemvindos,
                      style: ThemeText.h2title35White,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      Strings.descricaoAppLogin,
                      style: ThemeText.paragraph16White,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
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
                      login(context);
                      setState(() {
                        loadingGoogle = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: loadingGoogle
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
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
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  Strings.iniciaSessao,
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Aqui vai o texto de quem fez'),
              ),
              const SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      final provider = Provider.of<GoogleSignInProvider>(
        context,
        listen: false,
      );
      await provider.googleLogin();
      await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushNamed(context, '/'),
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
