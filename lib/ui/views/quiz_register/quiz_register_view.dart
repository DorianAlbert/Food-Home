import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/allergens_section/allergens_section.dart';
import '../../widgets/common/diet_selector/diet_selector.dart';
import '../../widgets/common/meals_slider_section/meals_slider_section.dart';
import '../../widgets/common/submit_button/submit_button.dart';
import 'quiz_register_viewmodel.dart';

class QuizRegisterView extends StackedView<QuizRegisterViewModel> {
  const QuizRegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      QuizRegisterViewModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: viewModel.isBusy && !viewModel.isEditing
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            // 🔹 Contenu scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Header / contexte =====
                    Text(
                      'Questionnaire alimentaire',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Parle-nous de tes contraintes et habitudes alimentaires.\n"
                          "On adaptera ensuite les menus et les suggestions.",
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Optionnel : indication d’étape
                    Text(
                      'Étape 2 sur 2',
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== Bloc allergies =====
                    _SectionCard(
                      title: 'Allergies et intolérances',
                      subtitle:
                      'Sélectionne les allergènes que tu dois éviter.',
                      child: AllergensSection(
                        allergens: viewModel.allergens,
                        onToggle: viewModel.toggleAllergen,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== Bloc régime =====
                    _SectionCard(
                      title: 'Type de régime',
                      subtitle:
                      'On adapte les recettes en fonction de ton profil.',
                      child: DietSelector(
                        selected: viewModel.dietType,
                        onSelected: viewModel.setDietType,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== Bloc fréquence viande/poisson =====
                    _SectionCard(
                      title: 'Fréquence des repas',
                      subtitle:
                      'Indique en moyenne combien de repas par semaine contiennent :',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MealsSliderSection(
                            label: 'Repas avec viande / semaine',
                            value: viewModel.meatMealsPerWeek,
                            onChanged: viewModel.setMeatMeals,
                          ),
                          const SizedBox(height: 16),
                          MealsSliderSection(
                            label: 'Repas avec poisson / semaine',
                            value: viewModel.fishMealsPerWeek,
                            onChanged: viewModel.setFishMeals,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // 🔹 Bouton de validation fixé en bas
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SubmitButton(
                isBusy: viewModel.isBusy,
                onPressed: viewModel.submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  QuizRegisterViewModel viewModelBuilder(
      BuildContext context,
      ) =>
      QuizRegisterViewModel();

  @override
  void onViewModelReady(QuizRegisterViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}

/// Petit widget interne pour homogénéiser les sections du questionnaire.
/// Utilise le thème (surface, onSurface, shadow, radius) pour rester cohérent.
class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const _SectionCard({
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre section
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
