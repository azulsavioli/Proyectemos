import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/google_sign_in.dart';

class LoginController {
  Future<bool> login(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return provider.signIn();
  }
}
