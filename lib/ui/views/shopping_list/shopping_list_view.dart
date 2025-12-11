import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


import '../../common/app_theme_extras.dart';
import '../../widgets/common/shopping_list_add_bar/shopping_list_add_bar.dart';
import '../../widgets/common/shopping_list_category_section/shopping_list_category_section.dart';
import 'shopping_list_viewmodel.dart';

class ShoppingListView extends StackedView<ShoppingListViewModel> {
  const ShoppingListView({super.key});

  @override
  Widget builder(
      BuildContext context,
      ShoppingListViewModel viewModel,
      Widget? child,
      ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final extras = theme.extension<AppThemeExtras>();

    final itemsByCategory = viewModel.itemsByCategory;

    Widget buildBody() {
      if (viewModel.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Une erreur est survenue lors du chargement de la liste de courses :\n${viewModel.modelError}',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
          ),
        );
      }

      // ⏳ Premier chargement
      if (viewModel.isBusy && viewModel.data == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (itemsByCategory.isEmpty) {
        return Column(
          children: [
            // barre d’ajout
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ShoppingListAddBar(
                productController: viewModel.productNameController,
                categories: viewModel.categories,
                selectedCategory: viewModel.selectedCategory,
                onCategoryChanged: viewModel.setSelectedCategory,
                onAdd: viewModel.addFromForm,
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  child: Text(
                    "Ta liste de courses est vide.\nAjoute un produit pour commencer.",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ShoppingListAddBar(
              productController: viewModel.productNameController,
              categories: viewModel.categories,
              selectedCategory: viewModel.selectedCategory,
              onCategoryChanged: viewModel.setSelectedCategory,
              onAdd: viewModel.addFromForm,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              children: itemsByCategory.entries
                  .map(
                    (entry) => ShoppingListCategorySection(
                  category: entry.key,
                  items: entry.value,
                  onIncrement: viewModel.incrementQuantity,
                  onDecrement: viewModel.decrementQuantity,
                  onDelete: viewModel.deleteItem,
                ),
              )
                  .toList(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        title: Text(
          'Liste de courses',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
        ),
      ),

      body: buildBody(),
    );
  }

  @override
  ShoppingListViewModel viewModelBuilder(BuildContext context) =>
      ShoppingListViewModel();
}
