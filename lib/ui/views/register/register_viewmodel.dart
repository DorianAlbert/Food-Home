import 'package:flutter/material.dart';
import 'package:food_home_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:food_home_app/app/app.locator.dart';
import 'package:food_home_app/services/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (isBusy) return;

    setBusy(true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        _snackbarService.showSnackbar(
          message: 'Merci de renseigner tous les champs.',
        );
        return;
      }

      if (password != confirmPassword) {
        _snackbarService.showSnackbar(
          message: 'Les mots de passe ne correspondent pas.',
        );
        return;
      }

      if (password.length < 6) {
        _snackbarService.showSnackbar(
          message: 'Le mot de passe doit contenir au moins 6 caractères.',
        );
        return;
      }
      try {
        await _authService.registerWithEmail(
          email: email,
          password: password,
        );
      }
      catch (e) {
        print(e);
      }
      _navigationService.replaceWithRegisterFormView();
    } on FirebaseAuthException catch (e) {
      String msg = 'Une erreur est survenue.';

      switch (e.code) {
        case 'email-already-in-use':
          msg = 'Cet email est déjà utilisé.';
          break;
        case 'invalid-email':
          msg = 'Adresse email invalide.';
          break;
        case 'weak-password':
          msg = 'Mot de passe trop faible.';
          break;
        default:
          msg = e.message ?? msg;
      }

      _snackbarService.showSnackbar(message: msg);
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Erreur inattendue : $e',
      );
    } finally {
      setBusy(false);
    }
  }
}
