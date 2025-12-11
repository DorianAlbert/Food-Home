import 'package:flutter/material.dart';

import '../../../../models/shopping_item_model.dart';
import '../shopping_list_item_row/shopping_list_item_row.dart';

class ShoppingListCategorySection extends StatelessWidget {
  final String category;
  final List<ShoppingItem> items;
  final void Function(String itemId) onIncrement;
  final void Function(String itemId) onDecrement;
  final void Function(String itemId) onDelete;

  const ShoppingListCategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de catégorie (Laitages, Boulangerie, etc.)
          Text(
            category,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
                (item) => ShoppingListItemRow(
              item: item,
              onIncrement: () => onIncrement(item.id),
              onDecrement: () => onDecrement(item.id),
              onDelete: () => onDelete(item.id),
            ),
          ),
        ],
      ),
    );
  }
}
