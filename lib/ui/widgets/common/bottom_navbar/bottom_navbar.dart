import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bottom_navbar_model.dart';

class BottomNavbar extends StackedView<BottomNavbarModel> {
  const BottomNavbar({super.key});

  Color _itemColor(BuildContext context, bool isActive) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isActive) {
      return colorScheme.primary; // bleu Food Home
    }

    // Couleur de texte secondaire pour les items inactifs
    return colorScheme.onSurface.withOpacity(0.45);
  }

  @override
  Widget builder(
    BuildContext context,
    BottomNavbarModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.12),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            label: 'Accueil',
            icon: Icons.home,
            color: _itemColor(context, viewModel.currentIndex == 0),
            onTap: viewModel.setAcceuil,
          ),
          GestureDetector(
            onTap: viewModel.onPlusTap,
            child: Container(
              width: 56,
              height: 56,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: colorScheme.onPrimary,
                size: 28,
              ),
            ),
          ),
          _NavItem(
            label: 'Profil',
            icon: Icons.person,
            color: _itemColor(context, viewModel.currentIndex == 1),
            onTap: viewModel.setProfil,
          ),
        ],
      ),
    );
  }

  @override
  BottomNavbarModel viewModelBuilder(BuildContext context) =>
      BottomNavbarModel();
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
