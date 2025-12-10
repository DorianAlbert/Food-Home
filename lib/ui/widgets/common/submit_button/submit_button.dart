import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
    const primary = Color(0xFF26B4E6);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isBusy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'Valider mon profil',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  @override
  SubmitButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      SubmitButtonModel();
}
