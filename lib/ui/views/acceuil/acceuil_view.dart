import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../widgets/common/home_action_card/home_action_card.dart';
import '../../widgets/common/meal_card/meal_card.dart';
import 'acceuil_viewmodel.dart';

class AcceuilView extends StackedView<AcceuilViewModel> {
  const AcceuilView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AcceuilViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------
              // HEADER
              // -------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      LucideIcons.utensilsCrossed,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Accueil',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text(
                "Aujourd'hui",
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),

              // -------------------------
              // CARTES REPAS
              // -------------------------
              MealCard(
                mealTypeLabel: 'Repas du midi',
                dishName: 'Wrap végétarien',
                ingredients: 'Tortillas, houmous, légumes grillés, feta',
                calories: 420,
                durationMinutes: 15,
                backgroundColor: AppColors.pastelBlue,
                // bleu / cyan utilisé pour les labels "repas du midi"
                labelColor: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              MealCard(
                mealTypeLabel: 'Repas du soir',
                dishName: 'Curry de légumes',
                ingredients: 'Légumes variés, lait de coco, curry, riz basmati',
                calories: 480,
                durationMinutes: 30,
                backgroundColor: AppColors.pastelPurple,
                // violet pour le repas du soir
                labelColor: AppColors.accentPurple,
              ),

              const SizedBox(height: 24),

              // -------------------------
              // GRILLE D’ACTIONS (2x2)
              // -------------------------
              Row(
                children: [
                  Expanded(
                    child: HomeActionCard(
                      icon: Icons.calendar_today_outlined,
                      iconBackground: AppColors.pastelBlue,
                      iconColor: theme.colorScheme.primary,
                      label: 'Menu &\nplanning',
                      onTap: viewModel.onMenuPlanningTap,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HomeActionCard(
                      icon: Icons.shopping_cart_outlined,
                      iconBackground: AppColors.pastelYellow,
                      iconColor: AppColors.accentYellow,
                      label: 'Liste de\ncourses',
                      onTap: viewModel.onShoppingListTap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: HomeActionCard(
                      icon: Icons.inventory_2_outlined,
                      iconBackground: AppColors.pastelPurple,
                      iconColor: AppColors.accentPurple,
                      label: 'Stock\nalimentaire',
                      onTap: viewModel.onStockTap,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HomeActionCard(
                      icon: Icons.settings_outlined,
                      iconBackground: AppColors.pastelGrey,
                      iconColor: AppColors.textMuted,
                      label: 'Paramètres',
                      onTap: viewModel.setProfil,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AcceuilViewModel viewModelBuilder(BuildContext context) => AcceuilViewModel();
}
