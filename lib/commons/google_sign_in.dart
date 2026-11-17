// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleSignInProvider extends ChangeNotifier {
//   final GoogleSignIn googleSignIn = GoogleSignIn.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   GoogleSignInAccount? _currentUser;
//
//   GoogleSignInAccount? get currentUser => _currentUser;
//   bool get isSignedIn => _currentUser != null;
//
//   GoogleSignInProvider() {
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     try {
//       // Inicializar o GoogleSignIn
//       await googleSignIn.initialize(
//         // Opcional: adicione clientId e serverClientId se necessário
//         // clientId: 'your-client-id',
//         // serverClientId: 'your-server-client-id',
//       );
//
//       // Escutar eventos de autenticação
//       googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent);
//
//       // Tentar autenticação leve
//       await googleSignIn.attemptLightweightAuthentication();
//
//       // Verificar se já existe usuário conectado
//       _currentUser = googleSignIn.currentUser;
//       if (_currentUser != null) {
//         await _firebaseAuth(_currentUser!);
//       }
//
//       notifyListeners();
//     } catch (error) {
//       debugPrint('GoogleSignIn initialization failed: $error');
//     }
//   }
//
//   void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
//     if (event is UserAuthenticated) {
//       _currentUser = event.user;
//       _firebaseAuth(event.user);
//       notifyListeners();
//     } else if (event is UserSignedOut) {
//       _currentUser = null;
//       notifyListeners();
//     }
//   }
//
//   Future<void> signIn() async {
//     try {
//       if (googleSignIn.supportsAuthenticate()) {
//         await googleSignIn.authenticate();
//       } else {
//         // Fallback para plataformas que não suportam authenticate()
//         final user = await googleSignIn.signIn();
//         if (user != null) {
//           _currentUser = user;
//           await _firebaseAuth(user);
//           notifyListeners();
//         }
//       }
//     } catch (error) {
//       debugPrint('Google Sign-In failed: $error');
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       await googleSignIn.signOut();
//       await googleSignIn.disconnect();
//       await auth.signOut();
//       _currentUser = null;
//       notifyListeners();
//     } catch (error) {
//       debugPrint('Google Sign-Out failed: $error');
//     }
//   }
//
//   Future<void> _firebaseAuth(GoogleSignInAccount user) async {
//     try {
//       final authData = await user.authentication;
//       final credential = GoogleAuthProvider.credential(
//         idToken: authData.idToken,
//         accessToken: authData.accessToken,
//       );
//       await auth.signInWithCredential(credential);
//     } catch (error) {
//       debugPrint('Firebase authentication failed: $error');
//     }
//   }
//
//   // Método para solicitar escopos adicionais se necessário
//   Future<void> requestScopes(List<String> scopes) async {
//     try {
//       if (_currentUser != null) {
//         await _currentUser!.authorizationClient.authorizeScopes(scopes);
//       }
//     } catch (error) {
//       debugPrint('Scope request failed: $error');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  bool get isSignedIn => _user != null;

  GoogleSignInProvider() {
    _init();
  }

  void _init() async {
    try {
      // Tenta restaurar login anterior
      final account = await GoogleSignIn.instance.attemptLightweightAuthentication();
      if (account != null) {
        _user = account;
        await _signInFirebase(account);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Init GoogleSignIn failed: $e');
    }
  }

  Future<void> signIn() async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      _user = account;
      await _signInFirebase(account);
      notifyListeners();
    } catch (e) {
      debugPrint('Google Sign-In failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.disconnect();
      _user = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Google Sign-Out failed: $e');
    }
  }

  Future<void> _signInFirebase(GoogleSignInAccount account) async {
    final googleAuth = account.authentication;
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    await _auth.signInWithCredential(credential);
  }

  Future<GoogleSignInAccount?> attemptLightweightSignIn() async {
    try {
      final account = await GoogleSignIn.instance.attemptLightweightAuthentication();
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
