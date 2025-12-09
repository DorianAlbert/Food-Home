import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/login_form_fields/login_form_fields.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('02 – Connexion'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
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
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 48),

                // Champs email / mot de passe
                LoginFormFields(
                  emailController: viewModel.emailController,
                  passwordController: viewModel.passwordController,
                ),
                const SizedBox(height: 24),

                // Bouton "Se connecter"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.isBusy ? null : viewModel.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade500,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: viewModel.isBusy
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),

                // Bouton "Créer un compte"
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: viewModel.navigateToRegister,
                    child: Text(
                      'Créer un compte',
                      style: TextStyle(
                        color: Colors.cyan.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Séparateur "Ou continuer avec"
                const _OrDivider(),

                const SizedBox(height: 24),

                // Boutons sociaux Google / Apple
                Column(
                  children: [
                    _SocialLoginButton(
                      label: 'Google',
                      onPressed: viewModel.signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 24),
                    ),
                    const SizedBox(height: 12),
                    _SocialLoginButton(
                      label: 'Apple',
                      onPressed:
                          viewModel.isBusy ? null : viewModel.signInWithApple,
                      icon: const Icon(Icons.apple, size: 20),
                    ),
                    const SizedBox(height: 12),
                    _SocialLoginButton(
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

/// Séparateur horizontal avec le texte "Ou continuer avec"
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Ou continuer avec',
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

/// Bouton générique pour la connexion sociale (Google / Apple)
class _SocialLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget icon;

  const _SocialLoginButton({
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade300;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
