import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'profile_details_viewmodel.dart';

class ProfileDetailsView extends StackedView<ProfileDetailsViewModel> {
  const ProfileDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileDetailsViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);

    // Chargement en cours ou user pas encore disponible
    if (viewModel.isBusy || viewModel.userProfile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mon profil'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final user = viewModel.userProfile!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: theme.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.prenom} ${user.nom}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text("Adresse"),
                  subtitle: Text(user.adresse),
                ),
                ListTile(
                  title: Text("Date de naissance"),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(user.dateDeNaissance)),
                ),
                Text(
                  'Adresse',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  user.adresse,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Date de naissance',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(user.dateDeNaissance),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                if (kDebugMode)...[
                Text(
                  'Identifiant',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  user.id,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[800],
                  ),
                ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProfileDetailsViewModel viewModelBuilder(BuildContext context) =>
      ProfileDetailsViewModel();

  @override
  void onViewModelReady(ProfileDetailsViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
