import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/user_model.dart';
import '../../../../services/user_service.dart';

class UserFormModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final User?
      initialUser; // L'utilisateur à modifier, peut être null pour la création

  UserFormModel(
      {this.initialUser}); // Le constructeur prend un utilisateur initial

  Future<void> handleSaveUser(User user) async {
    setBusy(true);
    try {
      if (initialUser == null) {
        // Mode création
        await _userService.addUser(
          id: user
              .id, // L'ID est déjà généré par le UserFormWidget pour la création
          nom: user.nom,
          prenom: user.prenom,
          dateDeNaissance: user.dateDeNaissance,
          adresse: user.adresse,
        );
        print('Utilisateur créé: ${user.nom} ${user.prenom}');
      } else {
        // Mode modification
        // Puisque addUser utilise .set(), il mettra à jour si l'ID existe.
        // Assurez-vous que l'ID de l'utilisateur passé est bien l'ID original pour la mise à jour.
        await _userService.addUser(
          id: user.id, // Doit être l'ID de l'initialUser pour la mise à jour
          nom: user.nom,
          prenom: user.prenom,
          dateDeNaissance: user.dateDeNaissance,
          adresse: user.adresse,
        );
        print('Utilisateur modifié: ${user.nom} ${user.prenom}');
      }
      // Après la sauvegarde, vous pourriez vouloir naviguer ailleurs ou afficher un message de succès
      // Par exemple: _navigationService.back(); ou _snackBarService.showSuccess('Utilisateur sauvegardé !');
    } catch (e) {
      print('Erreur lors de la sauvegarde de l\'utilisateur: $e');
      // Gérer l'erreur, par exemple, en affichant un SnackBar à l'utilisateur
    } finally {
      setBusy(false);
    }
  }
}
