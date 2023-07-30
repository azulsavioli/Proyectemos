import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectemos/commons/google_sign_in.dart';

class LoginController {
  Future<void> login() async {
    final provider = GoogleSignInProvider();
    try {
      await provider.googleLogin();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
