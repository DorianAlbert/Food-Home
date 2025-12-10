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
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Créer un Compte'), // Titre adapté pour l'enregistrement
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: viewModel
              .isBusy // Afficher un indicateur de chargement si le ViewModel est occupé
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: UserFormWidget(
                initialUser:
                    null, // Pas d'utilisateur initial pour un formulaire d'enregistrement
                onSave: viewModel
                    .handleRegisterUser, // Le callback pour la sauvegarde
              ),
            ),
    );
  }

  @override
  RegisterFormViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterFormViewModel();
}
