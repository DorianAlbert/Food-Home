import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bottom_navbar_model.dart';

class BottomNavbar extends StackedView<BottomNavbarModel> {
  const BottomNavbar({super.key});

  Color _itemColor(bool isActive) {
    return isActive ? const Color(0xFF10B981) : Colors.grey;
  }

  @override
  Widget builder(
    BuildContext context,
    BottomNavbarModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            label: 'Accueil',
            icon: Icons.home,
            color: _itemColor(viewModel.currentIndex == 0),
            onTap: () => viewModel.setAcceuil(),
          ),
          GestureDetector(
            onTap: viewModel.onPlusTap,
            child: Container(
              width: 56,
              height: 56,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          _NavItem(
            label: 'Profil',
            icon: Icons.person,
            color: _itemColor(viewModel.currentIndex == 1),
            onTap: () => viewModel.setProfil(),
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
            style: TextStyle(
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
