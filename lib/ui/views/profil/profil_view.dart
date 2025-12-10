import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_model.dart';

import '../../widgets/common/allergens_section/allergens_section.dart';
import '../../widgets/common/diet_selector/diet_selector.dart' show DietSelector;
import '../../widgets/common/meals_slider_section/meals_slider_section.dart';
import 'profil_viewmodel.dart';

class ProfilView extends StackedView<ProfilViewModel> {
  // Garde ce paramètre pour rester compatible avec app.router.dart
  final User? userProfile;

  const ProfilView({
    Key? key,
    this.userProfile,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      ProfilViewModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);

    final isLoading = viewModel.isBusy && viewModel.userProfile == null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -----------------------------
              // 1. Carte profil utilisateur
              // -----------------------------
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26B4E6),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          viewModel.initialLetter,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Nom / sous-titre
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.displayName,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              viewModel.displaySubtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Bouton "Voir mon profil"
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: viewModel.onViewProfilePressed,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: const Color(0xFFF7F8FA),
                  ),
                  child: const Text(
                    'Voir mon profil',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // -----------------------------
              // 2. Préférences alimentaires
              // -----------------------------
              Text(
                'Préférences alimentaires',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Allergènes
                      AllergensSection(
                        allergens: viewModel.allergens,
                        onToggle: viewModel.toggleAllergen,
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.shade200),
                      const SizedBox(height: 16),

                      // Régime alimentaire
                      DietSelector(
                        selected: viewModel.dietType,
                        onSelected: viewModel.setDietType,
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.shade200),
                      const SizedBox(height: 16),

                      // 🔹 Repas avec viande
                      MealsSliderSection(
                        label: 'Repas avec viande par semaine',
                        value: viewModel.meatMealsPerWeek,
                        onChanged: (double newValue) {
                          viewModel.setMeatMealsPerWeek(
                            newValue.toInt(),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // 🔹 Repas avec poisson
                      MealsSliderSection(
                        label: 'Repas avec poisson par semaine',
                        value: viewModel.fishMealsPerWeek,
                        onChanged: (double newValue) {
                          viewModel.setFishMealsPerWeek(
                            newValue.toInt(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // -----------------------------
              // 3. Notifications
              // -----------------------------
              Text(
                'Notifications',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Color(0xFFF4A623),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Alertes péremption',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Recevoir des notifications',
                              style:
                              theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: viewModel.expiryAlertsEnabled,
                        onChanged: viewModel.toggleExpiryAlerts,
                        activeColor: const Color(0xFF26B4E6),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // -----------------------------
              // 4. Compte
              // -----------------------------
              Text(
                'Compte',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xFFFFF2F2),
                child: ListTile(
                  onTap: viewModel.logout,
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Se déconnecter',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfilViewModel viewModelBuilder(BuildContext context) =>
      ProfilViewModel(userProfile: userProfile);

  @override
  void onViewModelReady(ProfilViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
