import 'package:food_home_app/services/user_service.dart';
import 'package:food_home_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:food_home_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:food_home_app/ui/views/home/home_view.dart';
import 'package:food_home_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:food_home_app/ui/views/login/login_view.dart';
import 'package:food_home_app/ui/views/register/register_view.dart';

import '../services/auth_service.dart';
import 'package:food_home_app/ui/views/profil/profil_view.dart';

import '../services/navbar_service.dart';
import 'package:food_home_app/ui/views/acceuil/acceuil_view.dart';
import 'package:food_home_app/ui/views/register_form/register_form_view.dart';
import 'package:food_home_app/ui/views/quiz_register/quiz_register_view.dart';

import '../services/quiz_service.dart';
import 'package:food_home_app/ui/views/profile_details/profile_details_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ProfilView),
    MaterialRoute(page: AcceuilView),
    MaterialRoute(page: RegisterFormView),
    MaterialRoute(page: QuizRegisterView),
    MaterialRoute(page: ProfileDetailsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: AuthService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavbarService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: QuizService),

    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
