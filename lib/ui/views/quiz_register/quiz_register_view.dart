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

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: viewModel.isBusy && !viewModel.isEditing
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // 🔹 Contenu scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titre
                          Text(
                            'Profil alimentaire',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),

                          AllergensSection(
                            allergens: viewModel.allergens,
                            onToggle: viewModel.toggleAllergen,
                          ),

                          const SizedBox(height: 32),

                          DietSelector(
                            selected: viewModel.dietType,
                            onSelected: viewModel.setDietType,
                          ),

                          const SizedBox(height: 32),

                          MealsSliderSection(
                            label: 'Repas avec viande / semaine',
                            value: viewModel.meatMealsPerWeek,
                            onChanged: viewModel.setMeatMeals,
                          ),

                          const SizedBox(height: 24),

                          MealsSliderSection(
                            label: 'Repas avec poisson / semaine',
                            value: viewModel.fishMealsPerWeek,
                            onChanged: viewModel.setFishMeals,
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Bouton de validation fixé en bas
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
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
