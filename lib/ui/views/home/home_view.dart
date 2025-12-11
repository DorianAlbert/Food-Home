import 'package:flutter/material.dart';
import 'package:food_home_app/ui/views/acceuil/acceuil_view.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/common/bottom_navbar/bottom_navbar.dart';
import '../../widgets/common/bottom_navbar/bottom_navbar_model.dart';
import '../profil/profil_view.dart';
import '../shopping_list/shopping_list_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (viewModel.currentIndex()) {
            case 0:
              return const AcceuilView();
            case 1:
              return const ProfilView();
            case 2:
              return const ShoppingListView();
            default:
              return const AcceuilView();
          }
        },
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
