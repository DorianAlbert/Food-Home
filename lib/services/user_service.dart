import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

import '../models/user_model.dart';

class UserService with ListenableServiceMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserService() {
    listenToReactiveValues([]);
  }

  Future<void> addUser({
    required String id,
    required String nom,
    required String prenom,
    required DateTime dateDeNaissance,
    required String adresse,
  }) async {
    if (id.isEmpty) {
      throw ArgumentError('User ID invalide');
    }

    final user = User(
      id: id,
      nom: nom,
      prenom: prenom,
      dateDeNaissance: dateDeNaissance,
      adresse: adresse,
    );

    await _firestore.collection('users').doc(id).set(user.toFirestore());
  }

  Future<User?> getUser(String id) async {
    final docSnapshot = await _firestore.collection('users').doc(id).get();
    if (docSnapshot.exists && docSnapshot.data() != null) {
      return User.fromFirestore(docSnapshot.id, docSnapshot.data()!);
    }
    return null;
  }

  Stream<List<User>> streamUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return User.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }
}
