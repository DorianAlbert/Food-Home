import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user_model.dart';
import '../../../models/quiz_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';
import '../../../services/quiz_service.dart';

class ProfilViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _quizService = locator<QuizService>();

  ProfilViewModel({User? userProfile}) {
    _userProfile = userProfile;
  }

  // -----------------------------
  // User profil
  // -----------------------------
  User? _userProfile;
  User? get userProfile => _userProfile;

  // -----------------------------
  // Préférences alimentaires
  // -----------------------------
  final Map<String, bool> _allergens = {
    'gluten': false,
    'lactose': false,
    'nuts': false,
    'eggs': false,
  };

  DietType _dietType = DietType.omnivore;

  // Valeurs utilisées par le quiz + maintenant par les sliders du profil
  int _meatMealsPerWeek = 0;
  int _fishMealsPerWeek = 0;

  Map<String, bool> get allergens => _allergens;
  DietType get dietType => _dietType;

  int get meatMealsPerWeek => _meatMealsPerWeek;
  int get fishMealsPerWeek => _fishMealsPerWeek;

  // -----------------------------
  // Notifications
  // -----------------------------
  bool _expiryAlertsEnabled = true;
  bool get expiryAlertsEnabled => _expiryAlertsEnabled;

  // -----------------------------
  // Initialisation
  // -----------------------------
  @override
  Future<void> initialise() async {
    setBusy(true);
    try {
      // Charger l'utilisateur si non fourni
      if (_userProfile == null) {
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        if (currentUserId != null) {
          _userProfile = await _userService.getUser(currentUserId);
        }
      }

      //préférences alimentaires depuis le quiz
      final quiz = await _quizService.getCurrentUserQuiz();
      if (quiz != null) {
        for (final key in _allergens.keys.toList()) {
          _allergens[key] = quiz.allergens.contains(key);
        }
        _dietType = quiz.dietType;
        _meatMealsPerWeek = quiz.meatMealsPerWeek;
        _fishMealsPerWeek = quiz.fishMealsPerWeek;
      }

      // TODO: charger l'état réel des notifications (Firestore / prefs)
      _expiryAlertsEnabled = true;
    } catch (e) {
      // log si besoin
      // print('Erreur ProfilViewModel.initialise: $e');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  // -----------------------------
  // Helpers d'affichage
  // -----------------------------
  String get initialLetter {
    if (_userProfile == null) return '?';
    final prenom = _userProfile!.prenom.trim();
    if (prenom.isEmpty) return '?';
    return prenom[0].toUpperCase();
  }

  String get displayName {
    if (_userProfile == null) return 'Utilisateur';
    return '${_userProfile!.prenom} ${_userProfile!.nom}';
  }

  String get displaySubtitle {
    if (_userProfile == null) return '';
    // Ici tu peux mettre email, pseudo, etc.
    return _userProfile!.prenom.toLowerCase();
  }

  // -----------------------------
  // Préférences alimentaires
  // -----------------------------
  void toggleAllergen(String key) {
    _allergens[key] = !(_allergens[key] ?? false);
    notifyListeners();
    _persistQuiz();
  }

  void setDietType(DietType value) {
    _dietType = value;
    notifyListeners();
    _persistQuiz();
  }

  void setMeatMealsPerWeek(int value) {
    _meatMealsPerWeek = value;
    notifyListeners();
    _persistQuiz();
  }

  void setFishMealsPerWeek(int value) {
    _fishMealsPerWeek = value;
    notifyListeners();
    _persistQuiz();
  }

  Future<void> _persistQuiz() async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final selectedAllergens = _allergens.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    final quiz = QuizModel(
      allergens: selectedAllergens,
      dietType: _dietType,
      meatMealsPerWeek: _meatMealsPerWeek,
      fishMealsPerWeek: _fishMealsPerWeek,
    );

    await _quizService.saveCurrentUserQuiz(quiz);
  }

  // -----------------------------
  // Notifications
  // -----------------------------
  void toggleExpiryAlerts(bool value) {
    _expiryAlertsEnabled = value;
    notifyListeners();

    // TODO: persister l'état des notifications
  }

  // -----------------------------
  // Navigation "Voir mon profil"
  // -----------------------------
  void onViewProfilePressed() {
    if (_userProfile == null) return;
    _navigationService.navigateToProfileDetailsView();
  }

  // -----------------------------
  // Déconnexion
  // -----------------------------
  Future<void> logout() async {
    await _authService.signOut();
    _navigationService.replaceWithLoginView();
  }
}
