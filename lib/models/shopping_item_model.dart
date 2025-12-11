// lib/models/shopping_item.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItem {
  final String id;
  final String name;
  final String category;
  final int quantity;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
  });

  factory ShoppingItem.fromDoc(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};

    return ShoppingItem(
      id: doc.id,
      name: (data['name'] as String?) ?? '',
      category: (data['category'] as String?) ?? 'Autre',
      quantity: (data['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
    };
  }
}
