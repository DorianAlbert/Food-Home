import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_model.dart';
import '../../common/app_colors.dart';
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
    final textTheme = theme.textTheme;

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
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          viewModel.initialLetter,
                          style: textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
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
                              style:
                              textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              viewModel.displaySubtitle,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.mutedForeground,
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
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: AppColors.sidebar,
                  ),
                  child: Text(
                    'Voir mon profil',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
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
                style: textTheme.titleMedium?.copyWith(
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
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 16),

                      // Régime alimentaire
                      DietSelector(
                        selected: viewModel.dietType,
                        onSelected: viewModel.setDietType,
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: AppColors.border),
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
                style: textTheme.titleMedium?.copyWith(
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
                          color: AppColors.pastelYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: AppColors.accentYellow,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alertes péremption',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Recevoir des notifications',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: viewModel.expiryAlertsEnabled,
                        onChanged: viewModel.toggleExpiryAlerts,
                        activeColor: theme.colorScheme.primary,
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
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: AppColors.destructive.withOpacity(0.06),
                child: ListTile(
                  onTap: viewModel.logout,
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.destructive,
                  ),
                  title: const Text(
                    'Se déconnecter',
                    style: TextStyle(
                      color: AppColors.destructive,
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
