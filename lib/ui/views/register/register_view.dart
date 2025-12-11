import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/auth_credentials_fields/auth_credentials_fields.dart';
import '../../widgets/common/auth_primary_button/auth_primary_button.dart';
import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      RegisterViewModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // un peu plus “form”
            children: [
              Text(
                'Créer un compte',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 32),
              AuthCredentialsFields(
                emailController: viewModel.emailController,
                passwordController: viewModel.passwordController,
                confirmPasswordController: viewModel.confirmPasswordController,
                showConfirmPassword: true,
              ),
              const SizedBox(height: 32),
              AuthPrimaryButton(
                label: 'S’inscrire',
                isLoading: viewModel.isBusy,
                onPressed: viewModel.register,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();
}
