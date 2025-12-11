// lib/ui/views/shopping_list/shopping_list_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/shopping_item_model.dart';
import '../../../services/shopping_list_service.dart';

class ShoppingListViewModel extends StreamViewModel<List<ShoppingItem>> {
  final _shoppingListService = locator<ShoppingListService>();

  // ----- état UI -----
  final TextEditingController productNameController = TextEditingController();

  final List<String> categories = const [
    'Fruits & Légumes',
    'Laitages',
    'Boulangerie',
    'Épicerie',
    'Viandes',
    'Poissons',
    'Surgelés',
    'Boissons',
  ];

  String _selectedCategory = 'Fruits & Légumes';
  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  /// 🔁 branchement au stream Firestore
  @override
  Stream<List<ShoppingItem>> get stream =>
      _shoppingListService.watchShoppingList();

  /// Données courantes
  List<ShoppingItem> get items => data ?? [];

  Map<String, List<ShoppingItem>> get itemsByCategory {
    final Map<String, List<ShoppingItem>> grouped = {};
    for (final item in items) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }
    return grouped;
  }

  // -------- Actions --------

  Future<void> addFromForm() async {
    final name = productNameController.text.trim();
    if (name.isEmpty) return;

    await _shoppingListService.addItem(
      name: name,
      category: _selectedCategory,
      quantity: 1,
    );
    productNameController.clear();
  }

  Future<void> deleteItem(String itemId) async {
    await _shoppingListService.deleteItem(itemId);
  }

  Future<void> incrementQuantity(String itemId) async {
    await _shoppingListService.incrementQuantity(itemId: itemId, delta: 1);
  }

  Future<void> decrementQuantity(String itemId) async {
    await _shoppingListService.incrementQuantity(itemId: itemId, delta: -1);
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
  }
}
