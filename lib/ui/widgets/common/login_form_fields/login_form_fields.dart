import 'package:flutter/material.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 1,
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
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(focusColor),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Mot de passe',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(focusColor),
          ),
        ),
      ],
    );
  }
}
