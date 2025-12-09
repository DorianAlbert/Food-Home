import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart'; // Import for Navigation and Snackbar
//import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // For Apple Sign-In

import '../../../app/app.router.dart'; // Assuming your generated app.router.dart

class LoginViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final _snackbarService = SnackbarService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Handles email and password login.
  Future<void> login() async {
    setBusy(true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        _snackbarService.showSnackbar(
          message: 'Please enter both email and password.',
          title: 'Error',
        );
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home screen on successful login
      _navigationService
          .replaceWithHomeView(); // Assuming HomeView is your main screen
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'Invalid email or password.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This user account has been disabled.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred during login.';
      }
      _snackbarService.showSnackbar(
        message: errorMessage,
        title: 'Login Failed',
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        message: e.toString(),
        title: 'An unexpected error occurred',
      );
    } finally {
      setBusy(false);
    }
  }

  /// Handles Google Sign-In.
  Future<void> signInWithGoogle() async {
    /**
    setBusy(true);
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn()
          .signIn(); // Use GoogleSignIn().signIn() directly

      if (googleUser == null) {
        // User cancelled the sign-in
        _snackbarService.showSnackbar(
            message: 'Google Sign-In cancelled.', title: 'Info');
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the home screen on successful login
      _navigationService.replaceWithHomeView();
    } on FirebaseAuthException catch (e) {
      _snackbarService.showSnackbar(
        message: e.message ?? 'Google Sign-In failed.',
        title: 'Authentication Error',
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        message: e.toString(),
        title: 'An unexpected error occurred during Google Sign-In',
      );
    } finally {
      setBusy(false);
    }
        **/
  }

  /// Handles Facebook Sign-In.
  Future<void> signInWithFacebook() async {
    /**
    setBusy(true);
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.cancelled) {
        _snackbarService.showSnackbar(
            message: 'Facebook Sign-In cancelled.', title: 'Info');
        return;
      }
      if (loginResult.status == LoginStatus.failed) {
        _snackbarService.showSnackbar(
            message: loginResult.message ?? 'Facebook Sign-In failed.',
            title: 'Error');
        return;
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Sign in to Firebase with the credential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      // Navigate to the home screen on successful login
      _navigationService.replaceWithHomeView();
    } on FirebaseAuthException catch (e) {
      _snackbarService.showSnackbar(
        message: e.message ?? 'Facebook Sign-In failed.',
        title: 'Authentication Error',
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        message: e.toString(),
        title: 'An unexpected error occurred during Facebook Sign-In',
      );
    } finally {
      setBusy(false);
    }
     **/
  }

  Future<void> signInWithApple() async {}

  /// Navigates to the registration screen.
  Future<void> navigateToRegister() async {
    await _navigationService.navigateTo(Routes.registerView);
  }
}
