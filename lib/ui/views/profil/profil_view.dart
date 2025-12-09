import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model.dart';
import 'profil_viewmodel.dart';

class ProfilView extends StackedView<ProfilViewModel> {
  // L'utilisateur dont le profil doit être affiché. Il peut être null.
  final User? userProfile;

  const ProfilView({Key? key, this.userProfile}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      ProfilViewModel viewModel,
      Widget? child,
      ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: viewModel.isBusy
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ CONTENU CONDITIONNEL
            if (viewModel.userProfile != null) ...[
              Text(
                'ID: ${viewModel.userProfile!.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Nom: ${viewModel.userProfile!.nom}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Prénom: ${viewModel.userProfile!.prenom}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Date de Naissance: ${DateFormat('dd/MM/yyyy').format(viewModel.userProfile!.dateDeNaissance)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Adresse: ${viewModel.userProfile!.adresse}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ] else ...[
              const Text(
                'Aucune donnée de profil disponible.',
                style: TextStyle(fontSize: 16),
              ),
            ],

            const Spacer(),

            // ✅ BOUTON TOUJOURS VISIBLE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: viewModel.logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Se déconnecter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfilViewModel viewModelBuilder(BuildContext context) =>
      ProfilViewModel(userProfile: userProfile);
}
