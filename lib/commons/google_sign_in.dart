import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  bool get isSignedIn => _user != null;

  GoogleSignInProvider() {
    _init();
  }

  void _init() async {
    final clientId = dotenv.env['CLIENT_ID'];
    final serverClientId = dotenv.env['SERVER_CLIENT_ID'];
    if (clientId == null || serverClientId == null) return;

    await _googleSignIn.initialize(clientId: clientId, serverClientId: serverClientId);
    _googleSignIn.authenticationEvents
        .listen(_handleAuthenticationEvent)
        .onError(_handleAuthenticationError);

    final prefs = await SharedPreferences.getInstance();
    final hasLoggedInBefore = prefs.getBool('hasLoggedInBefore') ?? false;

    if (hasLoggedInBefore) {
      final account = await _googleSignIn.attemptLightweightAuthentication();
      if (account != null) {
        _user = account;
        await _signInFirebase(account);
        notifyListeners();
        debugPrint('✅ Login silencioso realizado: ${account.email}');
      }
    } else {
      debugPrint('ℹ️ Usuário nunca logou antes, não tenta login silencioso');
    }
  }

  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    switch (event.runtimeType) {
      case GoogleSignInAuthenticationEventSignIn:
        _user = (event as GoogleSignInAuthenticationEventSignIn).user;
        if (_user != null) {
          await _signInFirebase(_user!);
        }
        break;
      case GoogleSignInAuthenticationEventSignOut:
        _user = null;
        break;
    }
    notifyListeners();
  }

  Future<void> _handleAuthenticationError(Object e) async {
    if (e is GoogleSignInException && e.code == 'canceled') {
      debugPrint('Usuário cancelou o login do Google.');
    } else {
      debugPrint('GoogleSignIn event error: $e');
    }
    _user = null;
    notifyListeners();
  }

  Future<void> signIn() async {
    try {
      if (_googleSignIn.supportsAuthenticate()) {
        final account = await _googleSignIn.authenticate();
        if (account != null) {
          _user = account;
          await _signInFirebase(account);
          notifyListeners();
        }
      } else {
        debugPrint('Authenticate not supported on this platform.');
      }
    } catch (e) {
      debugPrint('Google Sign-In failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.disconnect();
      _user = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Google Sign-Out failed: $e');
    }
  }

  Future<void> _signInFirebase(GoogleSignInAccount account) async {
    final googleAuth = await account.authentication;
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    await _auth.signInWithCredential(credential);
  }

  Future<GoogleSignInAccount?> attemptLightweightSignIn() async {
    try {
      final account = await _googleSignIn.attemptLightweightAuthentication();
      if (account != null) {
        _user = account;
        await _signInFirebase(account);
        notifyListeners();
      }
      return account;
    } catch (e) {
      debugPrint('Lightweight sign-in failed: $e');
      return null;
    }
  }
}
