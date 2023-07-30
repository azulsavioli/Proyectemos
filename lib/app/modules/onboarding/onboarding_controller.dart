import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController {
  Future<void> storeOnboardingInfo() async {
    const isCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('onboarding', isCompleted);
  }
}
