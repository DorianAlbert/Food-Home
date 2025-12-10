import 'package:food_home_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:food_home_app/app/app.locator.dart';
import 'package:food_home_app/services/quiz_service.dart';
import 'package:food_home_app/models/quiz_model.dart';
import 'package:stacked_services/stacked_services.dart';

class QuizRegisterViewModel extends BaseViewModel {
  final _quizService = locator<QuizService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final Map<String, bool> _allergens = {
    'gluten': false,
    'lactose': false,
    'nuts': false,
    'eggs': false,
  };

  DietType _dietType = DietType.omnivore;
  int _meatMealsPerWeek = 3;
  int _fishMealsPerWeek = 2;

  bool _isEditing = false;

  Map<String, bool> get allergens => _allergens;
  DietType get dietType => _dietType;
  int get meatMealsPerWeek => _meatMealsPerWeek;
  int get fishMealsPerWeek => _fishMealsPerWeek;
  bool get isEditing => _isEditing;

  Future<void> initialise() async {
    setBusy(true);
    try {
      final existingQuiz = await _quizService.getCurrentUserQuiz();

      // 🔹 Cas MODIFICATION
      if (existingQuiz != null) {
        _isEditing = true;

        for (final key in _allergens.keys) {
          _allergens[key] = existingQuiz.allergens.contains(key);
        }

        _dietType = existingQuiz.dietType;
        _meatMealsPerWeek = existingQuiz.meatMealsPerWeek;
        _fishMealsPerWeek = existingQuiz.fishMealsPerWeek;
      }
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void toggleAllergen(String key) {
    _allergens[key] = !(_allergens[key] ?? false);
    notifyListeners();
  }

  void setDietType(DietType value) {
    _dietType = value;
    notifyListeners();
  }

  void setMeatMeals(double value) {
    _meatMealsPerWeek = value.round();
    notifyListeners();
  }

  void setFishMeals(double value) {
    _fishMealsPerWeek = value.round();
    notifyListeners();
  }

  bool _isValid() {
    // règles métier minimales (tu peux en ajouter)
    if (_meatMealsPerWeek + _fishMealsPerWeek == 0) {
      _snackbarService.showSnackbar(
        message: 'Veuillez sélectionner au moins un type de repas.',
      );
      return false;
    }
    return true;
  }

  Future<void> submit() async {
    if (!_isValid()) return;

    setBusy(true);
    try {
      final selectedAllergens =
          _allergens.entries.where((e) => e.value).map((e) => e.key).toList();

      final quiz = QuizModel(
        allergens: selectedAllergens,
        dietType: _dietType,
        meatMealsPerWeek: _meatMealsPerWeek,
        fishMealsPerWeek: _fishMealsPerWeek,
      );

      await _quizService.saveCurrentUserQuiz(quiz);

      _snackbarService.showSnackbar(
        message: _isEditing
            ? 'Profil alimentaire mis à jour'
            : 'Profil alimentaire enregistré',
      );

      _navigationService.replaceWithHomeView();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Erreur lors de l’enregistrement du profil',
      );
    } finally {
      setBusy(false);
    }
  }
}
