import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../commons/google_sign_in.dart';

GoogleSignInAccount? getCurrentUser(BuildContext context) {
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  var currentUser = provider.googleSignIn.currentUser;

  if (currentUser == null) {
    provider.googleSignIn.signInSilently();
    provider.googleLogin();
    currentUser = provider.googleSignIn.currentUser;
  }
  return currentUser;
}
