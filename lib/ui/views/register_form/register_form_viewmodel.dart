import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';

class RegisterFormViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  Future<void> handleRegisterUser(User newUser) async {
    setBusy(true);
    try {
      // Puisque c'est un formulaire d'enregistrement, on part du principe qu'on crée un nouvel utilisateur.
      // L'ID est généré par le UserFormWidget lors de la soumission.
      await _userService.addUser(
        id: newUser.id,
        nom: newUser.nom,
        prenom: newUser.prenom,
        dateDeNaissance: newUser.dateDeNaissance,
        adresse: newUser.adresse,
      );
      print('Nouvel utilisateur enregistré avec succès: ${newUser.nom} ${newUser.prenom}');
      // Ici, vous pourriez naviguer vers une page de succès, la page d'accueil,
      // ou afficher un message de confirmation.
      // Ex: _navigationService.replaceWithHomeView();
    } catch (e) {
      print('Erreur lors de l\'enregistrement de l\'utilisateur: $e');
      // Afficher un message d'erreur à l'utilisateur
      // Ex: _snackbarService.showError(message: 'Erreur d\'enregistrement: $e');
    } finally {
      setBusy(false);
    }
  }
}