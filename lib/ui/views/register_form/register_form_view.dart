import 'package:flutter/material.dart';
import 'package:food_home_app/ui/views/register_form/register_form_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/user_form/user_form.dart';

class RegisterFormView extends StackedView<RegisterFormViewModel> {
  const RegisterFormView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterFormViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      // ===== APP BAR FOOD HOME =====
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.background,
        title: Text(
          'Informations du compte',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),

      // ===== BODY =====
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: UserFormWidget(
                initialUser: null,
                onSave: viewModel.handleRegisterUser,
              ),
            ),
    );
  }

  @override
  RegisterFormViewModel viewModelBuilder(BuildContext context) =>
      RegisterFormViewModel();
}
