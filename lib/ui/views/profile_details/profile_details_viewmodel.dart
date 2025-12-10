import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';

class ProfileDetailsViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  User? _userProfile;
  User? get userProfile => _userProfile;

  @override
  Future<void> initialise() async {
    setBusy(true);
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        _userProfile = await _userService.getUser(currentUserId);
      }
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
