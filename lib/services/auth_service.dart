import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService({FirebaseAuth? firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // ---------- Email / Mot de passe ----------
  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ---------- Google ----------
  Future<void> signInWithGoogle() async {
    /**
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Connexion Google annulée par l’utilisateur.');
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
        **/
  }

  // ---------- Facebook ----------
  Future<UserCredential> signInWithFacebook() async {
    final result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      throw Exception('Connexion Facebook annulée ou échouée.');
    }

    final credential = FacebookAuthProvider.credential(
      result.accessToken!.tokenString,
    );

    return firebaseAuth.signInWithCredential(credential);
  }

  // ---------- Apple ----------
  Future<UserCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return firebaseAuth.signInWithCredential(oauthCredential);
  }

  // ---------- Utilitaires ----------
  User? get currentUser => firebaseAuth.currentUser;

  Future<void> signOut() => firebaseAuth.signOut();
}
