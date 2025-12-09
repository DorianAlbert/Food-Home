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

  // Convertit l'objet User en un format Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nom': nom,
      'prenom': prenom,
      'date_de_naissance':
          dateDeNaissance.toIso8601String(), // Stocker comme String ISO 8601
      'adresse': adresse,
    };
  }

  // Crée un objet User à partir d'un DocumentSnapshot Firestore
  factory User.fromFirestore(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      nom: data['nom'] as String,
      prenom: data['prenom'] as String,
      dateDeNaissance: DateTime.parse(data['date_de_naissance'] as String),
      adresse: data['adresse'] as String,
    );
  }
}
