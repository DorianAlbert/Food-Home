import 'package:flutter/material.dart';

import '../../../../models/shopping_item_model.dart';


class ShoppingListItemRow extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const ShoppingListItemRow({
    super.key,
    required this.item,
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Carré “checkbox”
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // Nom du produit avec tiret
          Expanded(
            child: Text(
              '- ${item.name}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ),

          // Bouton -
          IconButton(
            icon: const Icon(Icons.remove),
            splashRadius: 18,
            onPressed: onDecrement,
          ),

          // Quantité
          Text(
            item.quantity.toString(),
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onBackground,
            ),
          ),

          // Bouton +
          IconButton(
            icon: const Icon(Icons.add),
            splashRadius: 18,
            onPressed: onIncrement,
          ),

          // Poubelle
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.shade300,
            ),
            splashRadius: 18,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
