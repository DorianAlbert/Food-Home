import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme_extras.dart';
import 'submit_button_model.dart';

class SubmitButton extends StackedView<SubmitButtonModel> {
  final bool isBusy;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.isBusy,
    required this.onPressed,
  });

  @override
  Widget builder(
      BuildContext context,
      SubmitButtonModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final extras = theme.extension<AppThemeExtras>();

    final radius = extras?.radiusLg ?? 18.0;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isBusy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        child: isBusy
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              colorScheme.onPrimary,
            ),
          ),
        )
            : Text(
          'Valider mon profil',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  SubmitButtonModel viewModelBuilder(BuildContext context) =>
      SubmitButtonModel();
}
