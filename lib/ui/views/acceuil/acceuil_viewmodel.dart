import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/navbar_service.dart';

class AcceuilViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _navbarService = locator<NavbarService>();

  // TODO: quand tu auras les vraies vues, adapte les routes ici.
  void onMenuPlanningTap() {
    // _navigationService.navigateToMenuPlanningView();
  }

  void onStockTap() {
    // _navigationService.navigateToStockView();
  }

  void onSettingsTap() {}

  void setProfil() {
    _navbarService.setTab(1);
  }

  void setShoppingList() {
    _navbarService.setTab(2);
  }
}
