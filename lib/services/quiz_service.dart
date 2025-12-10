import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_home_app/app/app.locator.dart';
import 'package:food_home_app/services/auth_service.dart';

import '../models/quiz_model.dart';

class QuizService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = locator<AuthService>();

  String get _currentUid {
    final user = _authService.firebaseAuth.currentUser;
    if (user == null) {
      throw StateError('Aucun utilisateur connecté');
    }
    return user.uid;
  }

  DocumentReference<Map<String, dynamic>> _quizDocRef(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('data')
        .doc('food_profile');
  }

  /// Récupère le profil alimentaire de l’utilisateur courant
  Future<QuizModel?> getCurrentUserQuiz() async {
    final uid = _currentUid;
    final doc = await _quizDocRef(uid).get();

    if (!doc.exists || doc.data() == null) return null;

    return QuizModel.fromJson(doc.data()!);
  }

  /// Sauvegarde / met à jour le profil alimentaire de l’utilisateur courant
  Future<void> saveCurrentUserQuiz(QuizModel quiz) async {
    final uid = _currentUid;
    await _quizDocRef(uid).set(quiz.toJson(), SetOptions(merge: true));
  }
}
