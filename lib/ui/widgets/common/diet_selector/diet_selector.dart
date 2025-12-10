import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/quiz_model.dart';
import 'diet_selector_model.dart';

class DietSelector extends StackedView<DietSelectorModel> {
  final DietType selected;
  final void Function(DietType) onSelected;

  const DietSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget builder(
    BuildContext context,
    DietSelectorModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    const primary = Color(0xFF26B4E6);

    String labelFromDiet(DietType type) {
      switch (type) {
        case DietType.omnivore:
          return 'Omnivore';
        case DietType.vegetarian:
          return 'Végétarien';
        case DietType.vegan:
          return 'Végétalien';
        case DietType.pescatarian:
          return 'Pescotarien';
      }
    }

    Widget buildChip(DietType type) {
      final isSelected = type == selected;
      final bgColor = isSelected ? primary : const Color(0xFFF2F4F7);
      final textColor = isSelected ? Colors.white : const Color(0xFF1F2933);

      return GestureDetector(
        onTap: () => onSelected(type),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            labelFromDiet(type),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Régime alimentaire',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: DietType.values.map(buildChip).toList(),
        ),
      ],
    );
  }

  @override
  DietSelectorModel viewModelBuilder(
    BuildContext context,
  ) =>
      DietSelectorModel();
}
