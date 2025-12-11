import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme_extras.dart';
import 'home_action_card_model.dart';

class HomeActionCard extends StackedView<HomeActionCardModel> {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const HomeActionCard({
    Key? key,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeActionCardModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final extras = theme.extension<AppThemeExtras>();

    final radius = extras?.radiusLg ?? 20.0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeActionCardModel viewModelBuilder(BuildContext context) =>
      HomeActionCardModel();
}
