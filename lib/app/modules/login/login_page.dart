import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                          padding: const EdgeInsets.only(top: 50, bottom: 10),
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.asset(
                              Strings.loginImage,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.bemvindos,
                              style: ThemeText.h2title35White,
                              textAlign: TextAlign.center,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 24),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(ThemeColors.yellow),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _controller.login().then(
                                    (value) => Future.delayed(
                                      const Duration(seconds: 3),
                                      () => Navigator.pushNamed(context, '/'),
                                    ),
                                  );
                              setState(() {
                                loadingGoogle = true;
                              });
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
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(14),
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
                          style: ThemeText.paragraph12White,
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
