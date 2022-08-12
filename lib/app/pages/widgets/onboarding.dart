import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              pageChanged = index;
            });
          },
          controller: controller,
          children: [
            Container(
              color: Colors.red,
              child: const Center(
                  child: Text(
                "UNO",
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Container(
              color: Colors.blue,
              child: const Center(
                  child: Text(
                "DOS",
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Container(
              color: Colors.yellow,
              child: const Center(
                  child: Text(
                "TRES",
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
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
                      onPressed: () {},
                      child: const Text(
                        "Pular",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ))
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
                      )),
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
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "Concluir",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ))
                  : TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "Próximo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ))
            ],
          ),
        ),
      );
}
