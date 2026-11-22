import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/strings/strings.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  bool loadingGoogle = false;

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ThemeColors.loginBlueTop,
                      ThemeColors.loginBlueMid,
                      ThemeColors.loginBlueBottom,
                    ],
                  ),
                ),
              ),
            ),
            // Scrollable content
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 10),
                          child: Image.asset(
                            Strings.loginImage,
                            height: (shortestSide * 0.55).clamp(
                              160.0,
                              isMobile ? 280.0 : 460.0,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isMobile ? 20 : 40),
                            Text(
                              Strings.bemvindos,
                              style: isMobile
                                  ? ThemeText.h2title35White
                                  : ThemeText.h3title30White,
                            ),
                            SizedBox(height: isMobile ? 20 : 80),
                            Text(
                              Strings.descricaoAppLogin,
                              style: isMobile
                                  ? ThemeText.paragraph16White
                                  : ThemeText.paragraph12White,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: isMobile ? 20 : 50),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 24,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                ThemeColors.yellow,
                              ),
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                              shape:
                                  WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                            ),
                            onPressed: loadingGoogle
                                ? null
                                : () async {
                                    setState(() => loadingGoogle = true);
                                    final result = await _controller.login(
                                      context,
                                    );
                                    if (!context.mounted) return;
                                    if (result == SignInResult.cancelled) {
                                      setState(() => loadingGoogle = false);
                                      return;
                                    }
                                    if (result == SignInResult.success) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/',
                                        (_) => false,
                                      );
                                      return;
                                    }
                                    setState(() => loadingGoogle = false);
                                    final message =
                                        result == SignInResult.networkFailure
                                        ? 'Sem conexão. Verifique a rede e tente de novo.'
                                        : 'Não foi possível entrar com esta conta. Tente de novo.';
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)),
                                    );
                                  },
                            child: loadingGoogle
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: ThemeColors.nearBlack,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.google,
                                        color: ThemeColors.nearBlack,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          Strings.iniciaSessao,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: ThemeColors.nearBlack,
                                            fontSize: 16,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          Strings.capesDescription,
                          style: isMobile
                              ? ThemeText.paragraph12White
                              : ThemeText.paragraph8WhiteNormal,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
