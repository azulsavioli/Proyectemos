// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
//
// import '../commons/google_sign_in.dart';
//
// GoogleSignInAccount? getCurrentUser(BuildContext context) {
//   final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
//   var currentUser = provider.googleSignIn.currentUser;
//
//   if (currentUser == null) {
//     provider.googleSignIn.signInSilently();
//     provider.googleLogin();
//     currentUser = provider.googleSignIn.currentUser;
//   }
//   return currentUser;
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commons/google_sign_in.dart';
Future<dynamic> getCurrentUser(BuildContext context) async {
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

  // Se já tiver usuário logado
  if (provider.user != null) {
    return provider.user;
  }

  // Tenta restaurar login automaticamente
  final account = await provider.attemptLightweightSignIn();
  if (account != null) {
    return account;
  }

  // Se não tiver, abre login
  await provider.signIn();
  return provider.user;
}
