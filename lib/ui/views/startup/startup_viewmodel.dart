import 'package:food_home_app/services/auth_service.dart';
import 'package:food_home_app/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:food_home_app/app/app.locator.dart';
import 'package:food_home_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    //_navigationService.replaceWithQuizRegisterView();

    _authService.firebaseAuth.authStateChanges().listen((user) async {
      if (user == null) {
        _navigationService.replaceWithLoginView();
        return;
      }
      final userInDb = await _userService.getUser(user.uid);

      if (userInDb == null) {
        _navigationService.replaceWithRegisterFormView();
      } else {
        _navigationService.replaceWithHomeView();
      }
    });
  }
}
