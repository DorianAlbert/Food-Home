import 'package:flutter/material.dart';

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

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade300;
    final focusColor = Colors.cyan.shade500;

    return Column(
      children: [
        TextFormField(
          controller: emailController,
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
          controller: passwordController,
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
        if (showConfirmPassword) ...[
          const SizedBox(height: 16),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirmer le mot de passe',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: _buildBorder(borderColor),
              enabledBorder: _buildBorder(borderColor),
              focusedBorder: _buildBorder(focusColor),
            ),
          ),
        ],
      ],
    );
  }
}
