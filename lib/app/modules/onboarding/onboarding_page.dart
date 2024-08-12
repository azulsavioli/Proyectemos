import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/registration/registration_page.dart';
import 'package:proyectemos/repository/proyectemos_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_controller.dart';
import 'onboarding_pages/page_one.dart';
import 'onboarding_pages/page_three.dart';
import 'onboarding_pages/page_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  final _onboardingController = OnboardingController();
  int pageChanged = 0;

  final _repository = ProyectemosRepository();
  final schoolInformations = [];

  @override
  void initState() {
    schoolInformations.add(_repository.getAllSchools());
    super.initState();
  }

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
          children: const [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (pageChanged == 0)
                TextButton(
                  onPressed: () => {
                    _onboardingController.storeOnboardingInfo(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    ),
                  },
                  child: const Text(
                    'Pular',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                TextButton(
                  onPressed: () => controller.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
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
                    dotColor: Colors.white,
                  ),
                ),
              ),
              if (pageChanged == 2)
                TextButton(
                  onPressed: () => {
                    _onboardingController.storeOnboardingInfo(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    ),
                  },
                  child: const Text(
                    'Concluir',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                TextButton(
                  onPressed: () => controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                  child: const Text(
                    'Próximo',
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
