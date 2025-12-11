import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme_extras.dart';
import 'meal_card_model.dart';

class MealCard extends StackedView<MealCardModel> {
  final String mealTypeLabel;
  final String dishName;
  final String ingredients;
  final int calories;
  final int durationMinutes;
  final Color backgroundColor;
  final Color labelColor;

  const MealCard({
    Key? key,
    required this.mealTypeLabel,
    required this.dishName,
    required this.ingredients,
    required this.calories,
    required this.durationMinutes,
    required this.backgroundColor,
    required this.labelColor,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MealCardModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final extras = theme.extension<AppThemeExtras>();

    final radius = extras?.radiusXl ?? 20.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label type de repas (Midi, Soir, Petit-déj, etc.)
          Text(
            mealTypeLabel,
            style: textTheme.bodySmall?.copyWith(
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),

          // Nom du plat
          Text(
            dishName,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),

          // Ingrédients
          Text(
            ingredients,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),

          // Calories & durée
          Text(
            '$calories kcal • $durationMinutes min',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }

  @override
  MealCardModel viewModelBuilder(BuildContext context) => MealCardModel();
}
