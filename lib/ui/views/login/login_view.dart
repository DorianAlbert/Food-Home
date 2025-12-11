import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/auth_primary_button/auth_primary_button.dart';
import '../../widgets/common/login_form_fields/login_form_fields.dart';
import '../../widgets/common/or_divider/or_divider.dart';
import '../../widgets/common/social_login_button/social_login_button.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('02 – Connexion'),
        // le AppBarTheme du thème global gère couleurs/typo
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre "Connexion"
                Text(
                  'Connexion',
                  style: textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                // Champs email / mot de passe
                LoginFormFields(
                  emailController: viewModel.emailController,
                  passwordController: viewModel.passwordController,
                ),
                const SizedBox(height: 24),

                AuthPrimaryButton(
                  label: 'Se connecter',
                  isLoading: viewModel.isBusy,
                  onPressed: viewModel.login,
                ),
                // Bouton "Créer un compte"
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: viewModel.navigateToRegister,
                    child: Text(
                      'Créer un compte',
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Séparateur "Ou continuer avec"
                const OrDivider(),

                const SizedBox(height: 24),

                // Boutons sociaux Google / Apple / Facebook
                Column(
                  children: [
                    SocialLoginButton(
                      label: 'Google',
                      onPressed: viewModel.signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 24),
                    ),
                    const SizedBox(height: 12),
                    SocialLoginButton(
                      label: 'Apple',
                      onPressed:
                          viewModel.isBusy ? null : viewModel.signInWithApple,
                      icon: const Icon(Icons.apple, size: 20),
                    ),
                    const SizedBox(height: 12),
                    SocialLoginButton(
                      label: 'Facebook',
                      onPressed: viewModel.signInWithFacebook,
                      icon: const Icon(Icons.facebook, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
