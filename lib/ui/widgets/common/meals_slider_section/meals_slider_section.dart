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
    const primary = Color(0xFF26B4E6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + valeur à droite
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        // Slider stylé
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primary,
            inactiveTrackColor: Colors.grey.shade300,
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
