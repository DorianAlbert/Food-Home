import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'allergens_section_model.dart';

class AllergensSection extends StackedView<AllergensSectionModel> {
  final Map<String, bool> allergens;
  final void Function(String key) onToggle;

  const AllergensSection({
    super.key,
    required this.allergens,
    required this.onToggle,
  });

  @override
  Widget builder(
    BuildContext context,
    AllergensSectionModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);

    String labelFromKey(String key) {
      switch (key) {
        case 'gluten':
          return 'Gluten';
        case 'lactose':
          return 'Lactose';
        case 'nuts':
          return 'Nuts';
        case 'eggs':
          return 'Eggs';
        default:
          return key;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Allergènes',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...allergens.entries.map(
          (entry) => Theme(
            data: theme.copyWith(
              checkboxTheme: CheckboxThemeData(
                shape: const CircleBorder(),
                side: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
            ),
            child: CheckboxListTile(
              value: entry.value,
              onChanged: (_) => onToggle(entry.key),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(
                labelFromKey(entry.key),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  AllergensSectionModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllergensSectionModel();
}
