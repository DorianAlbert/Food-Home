import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:food_home_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';

class ProfilViewModel extends BaseViewModel {
  User? _userProfile;
  User? get userProfile => _userProfile;
  final _authService = locator<AuthService>();


  ProfilViewModel({User? userProfile}) {
    _userProfile = userProfile;
  }
  @override
  Future<void> initialise() async {
    if (_userProfile == null) {
      setBusy(true);
      try {
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        if (currentUserId != null) {
          _userProfile = await locator<UserService>().getUser(currentUserId);
        }
      } catch (e) {
        print('Erreur lors du chargement du profil: $e');
      } finally {
        setBusy(false);
        notifyListeners(); // Important pour rafraîchir la UI après le chargement
      }
    }
  }

  Future<void>logout() async{
    _authService.signOut();
  }
}
