import 'package:flutter/material.dart';

import '../../../common/app_theme_extras.dart';

class AuthCredentialsFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final bool showConfirmPassword;

  const AuthCredentialsFields({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.confirmPasswordController,
    this.showConfirmPassword = false,
  }) : super(key: key);

  OutlineInputBorder _buildBorder(Color color, double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Récupère les tokens du thème extras (radius + background input)
    final extras = theme.extension<AppThemeExtras>();

    // fallback si extras pas trouvés
    final radius = extras?.radiusMd ?? 10.0;
    final inputFill = extras?.inputBackground ?? colorScheme.surface;
    final borderColor = colorScheme.outline.withOpacity(0.3);
    final focusColor = colorScheme.primary;

    InputDecoration decoration(String hint) {
      return InputDecoration(
        hintText: hint,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: theme.hintColor,
        ),
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: _buildBorder(borderColor, radius),
        enabledBorder: _buildBorder(borderColor, radius),
        focusedBorder: _buildBorder(focusColor, radius),
      );
    }

    return Column(
      children: [
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
          decoration: decoration('Email'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
          decoration: decoration('Mot de passe'),
        ),
        if (showConfirmPassword) ...[
          const SizedBox(height: 16),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onBackground,
            ),
            decoration: decoration('Confirmer le mot de passe'),
          ),
        ],
      ],
    );
  }
}
