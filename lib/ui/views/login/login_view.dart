import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
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
                const _LoginFormFields(),
                const SizedBox(height: 24),

                // Bouton "Se connecter"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: implémenter la logique de connexion
                    },
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
                    child: const Text(
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
                    onPressed: () {
                      // TODO: navigation vers la création de compte
                    },
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
                      onPressed: () {
                        // TODO: implémenter login Google
                      },
                      // Remplace avec un vrai logo via flutter_svg si besoin
                      icon: const Icon(Icons.g_mobiledata, size: 24),
                    ),
                    const SizedBox(height: 12),
                    _SocialLoginButton(
                      label: 'Apple',
                      onPressed: () {
                        // TODO: implémenter login Apple
                      },
                      icon: const Icon(Icons.apple, size: 20),
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
}

/// Champs de formulaire: email + mot de passe
class _LoginFormFields extends StatelessWidget {
  const _LoginFormFields();

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 1.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade300;
    final focusColor = Colors.cyan.shade500;

    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: _buildBorder(borderColor),
            enabledBorder: _buildBorder(borderColor),
            focusedBorder: _buildBorder(focusColor),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Mot de passe',
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: _buildBorder(borderColor),
            enabledBorder: _buildBorder(borderColor),
            focusedBorder: _buildBorder(focusColor),
          ),
        ),
      ],
    );
  }
}
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

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
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
