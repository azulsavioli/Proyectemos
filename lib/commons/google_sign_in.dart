import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SignInResult { success, cancelled, networkFailure, accountFailure }

bool isNetworkSignInError(Object error) {
  if (error is SocketException || error is TimeoutException) return true;
  if (error is FirebaseAuthException &&
      (error.code == 'network-request-failed' || error.code == 'unavailable')) {
    return true;
  }
  final text = error.toString().toLowerCase();
  return text.contains('network') ||
      text.contains('socket') ||
      text.contains('timeout') ||
      text.contains('failed host lookup');
}

/// User dismissal of the Google account picker should stay silent.
bool isGoogleSignInCancellation(Object error) {
  if (error is GoogleSignInException &&
      error.code == GoogleSignInExceptionCode.canceled) {
    return true;
  }
  final text = error.toString().toLowerCase();
  return text.contains('sign_in_canceled') ||
      text.contains('sign_in_cancelled') ||
      text.contains('google_sign_in_canceled');
}

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  bool get isSignedIn => _user != null;

  GoogleSignInProvider() {
    _init();
  }

  Future<void> _init() async {
    try {
      _googleSignIn.authenticationEvents
          .listen(_handleAuthenticationEvent)
          .onError(_handleAuthenticationError);

      final prefs = await SharedPreferences.getInstance();
      final hasLoggedInBefore = prefs.getBool('hasLoggedInBefore') ?? false;
      if (!hasLoggedInBefore) return;

      final account = await _googleSignIn.attemptLightweightAuthentication();
      if (account != null) {
        _user = account;
        await _signInFirebase(account);
        notifyListeners();
        debugPrint('Login silencioso realizado: ${account.email}');
      }
    } catch (e) {
      debugPrint('Init GoogleSignIn failed: $e');
    }
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      _user = event.user;
      final signedIn = _user;
      if (signedIn != null) {
        await _signInFirebase(signedIn);
      }
    } else if (event is GoogleSignInAuthenticationEventSignOut) {
      _user = null;
    }
    notifyListeners();
  }

  Future<void> _handleAuthenticationError(Object e) async {
    if (e is GoogleSignInException &&
        e.code == GoogleSignInExceptionCode.canceled) {
      debugPrint('Usuário cancelou o login do Google.');
    } else {
      debugPrint('GoogleSignIn event error: $e');
    }
    _user = null;
    notifyListeners();
  }

  /// [SignInResult.cancelled] is a dismissed picker and should stay silent.
  Future<SignInResult> signIn() async {
    try {
      if (!_googleSignIn.supportsAuthenticate()) {
        debugPrint('Authenticate not supported on this platform.');
        return SignInResult.accountFailure;
      }
      final account = await _googleSignIn.authenticate();
      _user = account;
      await _signInFirebase(account);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasLoggedInBefore', true);
      notifyListeners();
      return _auth.currentUser != null
          ? SignInResult.success
          : SignInResult.accountFailure;
    } catch (e) {
      if (isGoogleSignInCancellation(e)) {
        debugPrint('Usuário cancelou o login do Google.');
        return SignInResult.cancelled;
      }
      debugPrint('Google Sign-In failed: $e');
      return isNetworkSignInError(e)
          ? SignInResult.networkFailure
          : SignInResult.accountFailure;
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
    final googleAuth = account.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
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
