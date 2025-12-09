import 'package:food_home_app/app/app.locator.dart';
import 'package:food_home_app/services/navbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavbarModel extends ReactiveViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _navbarService = locator<NavbarService>();

  int get currentIndex => _navbarService.currentIndex;

  void setProfil() {
    _navbarService.setTab(1);
  }

  void setAcceuil() {
    _navbarService.setTab(0);
  }

  Future<void> onPlusTap() async {
    await _bottomSheetService.showBottomSheet(
      title: 'Ajouter',
      description: 'Action du bouton +',
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_navbarService];
}
