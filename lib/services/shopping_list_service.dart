// lib/services/shopping_list_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../models/shopping_item_model.dart';


class ShoppingListService {
  final FirebaseFirestore _firestore;
  final fb.FirebaseAuth _auth;

  ShoppingListService({
    FirebaseFirestore? firestore,
    fb.FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? fb.FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('Aucun utilisateur connecté');
    }
    return user.uid;
  }

  /// /users/{uid}/data/shopping_list/items
  CollectionReference get _itemsRef {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('data')
        .doc('shopping_list')
        .collection('items');
  }

  /// 🔁 Stream temps réel
  Stream<List<ShoppingItem>> watchShoppingList() {
    return _itemsRef.snapshots().map((snapshot) {
      // Debug utile : tu verras ça dans la console
      // ignore: avoid_print
      print('Firestore shopping_list: ${snapshot.docs.length} docs');

      return snapshot.docs
          .map((doc) => ShoppingItem.fromDoc(doc))
          .toList();
    });
  }

  Future<void> addItem({
    required String name,
    required String category,
    int quantity = 1,
  }) async {
    await _itemsRef.add({
      'name': name.trim(),
      'category': category.trim(),
      'quantity': quantity,
    });
  }

  Future<void> deleteItem(String itemId) async {
    await _itemsRef.doc(itemId).delete();
  }

  Future<void> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    await _itemsRef.doc(itemId).update({
      'quantity': quantity,
    });
  }

  Future<void> incrementQuantity({
    required String itemId,
    int delta = 1,
  }) async {
    await _itemsRef.doc(itemId).update({
      'quantity': FieldValue.increment(delta),
    });
  }
}
