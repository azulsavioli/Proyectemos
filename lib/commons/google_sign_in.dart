import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = kIsWeb
      ? GoogleSignIn(
          scopes: ['email', 'https://mail.google.com/'],
        )
      : (defaultTargetPlatform == TargetPlatform.android)
          ? GoogleSignIn(
              scopes: ['https://mail.google.com/'],
            )
          : GoogleSignIn(
              scopes: ['email', 'https://mail.google.com/'],
              clientId:
                  '333978861746-p88q9nentd8ogn0q30e9qv24rjlouno5.apps.googleusercontent.com',
            );

  late GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        await auth.signInWithPopup(googleProvider);
        notifyListeners();
        return;
      }

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future googleLogout() async {
    await auth.signOut();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
