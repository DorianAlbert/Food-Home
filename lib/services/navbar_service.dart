import 'package:stacked/stacked.dart';

class NavbarService with ListenableServiceMixin {
  final ReactiveValue<int> _currentIndex = ReactiveValue<int>(0);

  int get currentIndex => _currentIndex.value;

  NavbarService() {
    listenToReactiveValues([_currentIndex]);
  }

  void setTab(int index) {
    _currentIndex.value = index;
  }
}
