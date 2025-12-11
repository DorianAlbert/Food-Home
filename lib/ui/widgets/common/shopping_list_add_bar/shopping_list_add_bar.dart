import 'package:flutter/material.dart';

import '../../../common/app_theme_extras.dart';


class ShoppingListAddBar extends StatelessWidget {
  final TextEditingController productController;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onAdd;

  const ShoppingListAddBar({
    super.key,
    required this.productController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final extras = theme.extension<AppThemeExtras>();

    final radius = extras?.radiusXl ?? 20.0;

    return Column(
      children: [
        // Ligne : champ "Nom du produit" + bouton +
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: productController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Nom du produit',
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onSubmitted: (_) => onAdd(),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 56,
              height: 56,
              child: ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Dropdown catégorie
        SizedBox(
          height: 52,
          child: DropdownButtonFormField<String>(
            value: selectedCategory,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
            items: categories
                .map(
                  (c) => DropdownMenuItem<String>(
                value: c,
                child: Text(c),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) onCategoryChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
