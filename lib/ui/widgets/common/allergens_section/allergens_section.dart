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
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    String labelFromKey(String key) {
      switch (key) {
        case 'gluten':
          return 'Gluten';
        case 'lactose':
          return 'Lactose';
        case 'nuts':
          return 'Fruits à coque';
        case 'eggs':
          return 'Œufs';
        default:
          return key;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Allergènes',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 12),
        ...allergens.entries.map(
              (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Theme(
              // On réutilise le thème global, mais on specialise le Checkbox
              data: theme.copyWith(
                checkboxTheme: theme.checkboxTheme.copyWith(
                  shape: const CircleBorder(),
                  side: MaterialStateBorderSide.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return BorderSide(
                        color: colorScheme.primary,
                        width: 1.5,
                      );
                    }
                    return BorderSide(
                      color: colorScheme.outline.withOpacity(0.6),
                      width: 1.5,
                    );
                  }),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return colorScheme.primary;
                    }
                    return Colors.transparent;
                  }),
                  checkColor: MaterialStateProperty.all(colorScheme.onPrimary),
                ),
              ),
              child: CheckboxListTile(
                value: entry.value,
                onChanged: (_) => onToggle(entry.key),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  labelFromKey(entry.key),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
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
