import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id; // L'ID du document Firestore
  final String nom;
  final String prenom;
  final DateTime dateDeNaissance;
  final String adresse;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.dateDeNaissance,
    required this.adresse,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'nom': nom,
      'prenom': prenom,
      'date_de_naissance': Timestamp.fromDate(dateDeNaissance),
      'adresse': adresse,
    };
  }

  factory User.fromFirestore(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      nom: data['nom'],
      prenom: data['prenom'],
      dateDeNaissance: (data['date_de_naissance'] as Timestamp).toDate(),
      adresse: data['adresse'],
    );
  }
}
