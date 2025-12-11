import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'meals_slider_section_model.dart';

class MealsSliderSection extends StackedView<MealsSliderSectionModel> {
  final String label;
  final int value;
  final ValueChanged<double> onChanged;

  const MealsSliderSection({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget builder(
    BuildContext context,
    MealsSliderSectionModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final primary = colorScheme.primary;
    final inactiveColor = colorScheme.outline.withOpacity(0.25);
    final labelColor = colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + valeur à droite
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: labelColor,
              ),
            ),
            Text(
              value.toString(),
              style: textTheme.bodyMedium?.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        // Slider stylé selon le thème
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primary,
            inactiveTrackColor: inactiveColor,
            thumbColor: primary,
            overlayColor: primary.withOpacity(0.16),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 14,
            divisions: 14,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  MealsSliderSectionModel viewModelBuilder(
    BuildContext context,
  ) =>
      MealsSliderSectionModel();
}
