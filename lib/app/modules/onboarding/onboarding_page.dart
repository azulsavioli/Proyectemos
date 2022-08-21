import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'page_one.dart';
import 'page_three.dart';
import 'page_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  storeOnboardingInfo() async {
    bool isCompleted = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('onboarding', isCompleted);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              pageChanged = index;
            });
          },
          controller: controller,
          children: const [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
        bottomSheet: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pageChanged == 0
                  ? TextButton(
                      onPressed: () => {
                        storeOnboardingInfo(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()))
                      },
                      child: const Text(
                        "Pular",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : TextButton(
                      onPressed: () => controller.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "Voltar",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.blueAccent,
                      dotColor: Colors.white),
                ),
              ),
              pageChanged == 2
                  ? TextButton(
                      onPressed: () => {
                        storeOnboardingInfo(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()))
                      },
                      child: const Text(
                        "Concluir",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "Próximo",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
}
