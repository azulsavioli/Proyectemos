import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                      Colors.blue.shade200,
                      Colors.blue.shade400,
                      Colors.blue.shade600,
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
                                    final ok = await _controller.login(context);
                                    if (!context.mounted) return;
                                    if (ok) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/',
                                        (_) => false,
                                      );
                                      return;
                                    }
                                    setState(() => loadingGoogle = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'No se pudo iniciar sesión. Inténtalo de nuevo.',
                                        ),
                                      ),
                                    );
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: loadingGoogle
                                  ? [
                                      const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]
                                  : [
                                      const FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          Strings.iniciaSessao,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
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
