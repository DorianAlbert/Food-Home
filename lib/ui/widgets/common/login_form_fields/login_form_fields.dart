import 'package:flutter/material.dart';

import '../../../common/app_theme_extras.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  OutlineInputBorder _border(Color color, double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: color,
        width: 1.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final radius = extras?.radiusLg ?? 16.0;
    final fillColor = extras?.inputBackground ?? colorScheme.surface;

    final borderColor = colorScheme.outline.withOpacity(0.3);
    final focusColor = colorScheme.primary;

    InputDecoration decoration(String hint) {
      return InputDecoration(
        hintText: hint,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: theme.hintColor,
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: _border(borderColor, radius),
        enabledBorder: _border(borderColor, radius),
        focusedBorder: _border(focusColor, radius),
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
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onBackground,
          ),
          decoration: decoration('Mot de passe'),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
