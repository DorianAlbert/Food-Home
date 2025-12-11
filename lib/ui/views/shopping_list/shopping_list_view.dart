import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'shopping_list_viewmodel.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShoppingListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("ShoppingListView")),
      ),
    );
  }

  @override
  ShoppingListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShoppingListViewModel();
}
