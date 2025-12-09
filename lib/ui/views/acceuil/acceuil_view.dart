import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'acceuil_viewmodel.dart';

class AcceuilView extends StackedView<AcceuilViewModel> {
  const AcceuilView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AcceuilViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("AcceuilView")),
      ),
    );
  }

  @override
  AcceuilViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AcceuilViewModel();
}
