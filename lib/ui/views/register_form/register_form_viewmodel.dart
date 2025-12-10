import 'package:food_home_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';

class RegisterFormViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  Future<void> handleRegisterUser(User newUser) async {
    setBusy(true);

    try {
      final firebaseUser = _authService.firebaseAuth.currentUser;

      if (firebaseUser == null) {
        throw Exception(
          'Aucun utilisateur Firebase connecté lors de l’enregistrement',
        );
      }

      await _userService.addUser(
        id: firebaseUser.uid, // ✅ UID sûr
        nom: newUser.nom,
        prenom: newUser.prenom,
        dateDeNaissance: newUser.dateDeNaissance,
        adresse: newUser.adresse,
      );

      _navigationService.replaceWithQuizRegisterView();
    } catch (e) {
      print('Erreur d’enregistrement utilisateur: $e');
    } finally {
      setBusy(false);
    }
  }
}
