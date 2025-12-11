import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'or_divider_model.dart';

class OrDivider extends StackedView<OrDividerModel> {
  const OrDivider({super.key});

  @override
  Widget builder(
      BuildContext context,
      OrDividerModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.border,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Ou continuer avec',
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.border,
          ),
        ),
      ],
    );
  }

  @override
  OrDividerModel viewModelBuilder(
      BuildContext context,
      ) =>
      OrDividerModel();
}
