import 'package:food_home_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:food_home_app/services/navbar_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navbarService = locator<NavbarService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_navbarService];

  int currentIndex() {
    return _navbarService.currentIndex;
  }
}
