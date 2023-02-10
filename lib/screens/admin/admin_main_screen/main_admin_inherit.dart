import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'body/admin_body_users/admin_new_users.dart';
import 'body/admin_body_users/new_user_screen.dart';
import 'body/admin_company_body/company_dody.dart';
import 'body/admin_company_body/new_company_body/new_company_body.dart';
import 'body/admin_line_body/admin_line_body.dart';
import 'body/objects_admin_body/object_admin_body.dart';

class MainAdminModel extends ChangeNotifier {
  final ApiSVD api = ApiSVD();

  bool showLittleTopBar = true, showBottomBar = true;

  // Flags for small top btn bar
  int topActiveBtn = 2;

  //Flags for bottom admin bar
  int bottomActiveBtn = 3;
  VoidCallback? backOnPressed;
  bool backIcon = false;
  String mainTitle = 'Панель\nадминистратора';
  String assetsImageFont = 'assets/app_bar/admin_main.png';
  Widget pickWidget = const AdminUsersMainInfo();
  List<User> allUsersCompany = [];

  // Main App Bar Tittle
  void updateMainTitle(String title) {
    mainTitle = title;
    notifyListeners();
  }

  void setNewUserCardWidgetToBody(User user) {
    pickWidget = NewUserBody(user: user,);
    showBottomBar = false;
    showLittleTopBar = false;
    backIcon = true;
    mainTitle = 'Новый\nпользователь';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    backOnPressed = () {
      setNewUsersWidgetToBody();
    };
    notifyListeners();
  }

  void setNewUsersWidgetToBody() {
    pickWidget = const AdminUsersMainInfo();
    showBottomBar = true;
    showLittleTopBar = true;
    backIcon = false;
    topActiveBtn = 1;
    mainTitle = 'Панель\nадминистратора';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  void setLineWidgetToBody() {
    pickWidget = const LineAdminBody();
    showBottomBar = true;
    showLittleTopBar = true;
    backIcon = false;
    mainTitle = 'Документы\nна согласовании';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  //-----------------------
  // Работаем с компаниями
  //-----------------------
  // Список всех компаний
  void setAllCompanyListWidgetToBody() {
    pickWidget = const AllCompanyListBody();
    showBottomBar = true;
    showLittleTopBar = true;
    backIcon = false;
    topActiveBtn = 1;
    mainTitle = 'Панель\nадминистратора';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }
  // Создаем новую компанию
  void setNewCompanyWidgetToBody([Company? company]) {
    pickWidget = NewCompanyAdminBody(company: company);
    showBottomBar = false;
    showLittleTopBar = false;
    backIcon = true;
    backOnPressed = () {
      setAllCompanyListWidgetToBody();
    };
    topActiveBtn = 1;
    mainTitle = 'Новое\nюридическое лицо';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  // Редактируем компанию
  void changeCompanyWidgetToBody() {
    pickWidget = const NewCompanyAdminBody();
    showBottomBar = false;
    showLittleTopBar = false;
    backIcon = true;
    backOnPressed = () {
      setAllCompanyListWidgetToBody();
    };
    topActiveBtn = 1;
    mainTitle = 'Новое\nюридическое лицо';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  void setObjectAdminWidgetToBody() {
    pickWidget = const ObjectAdminBody();
    showBottomBar = true;
    showLittleTopBar = true;
    backIcon = false;
    topActiveBtn = 2;
    mainTitle = 'Панель объектов';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  void updateAllUsersCompany(int companyId) async {
    allUsersCompany.clear();
    allUsersCompany = await api.usersInCompany(companyId);
    notifyListeners();
  }


  //------------------------
  // Активируем Элементы верхнего бара
  //------------------------
  void pickTopItem(int index) {
    topActiveBtn = index;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }

  //------------------------
  // Активируем Элементы нижнего бара
  //------------------------
  void pickBottomItem(int index) {
    bottomActiveBtn = index;
    if (index == 0) {
      setLineWidgetToBody();
    }
    if (index == 1) {
      mainTitle = 'Архив\nсогласованных докуметов';
      pickWidget = const Text('Архив\nсогласованных докуметов');
    }
    if (index == 2) {
      mainTitle = 'Новый документ';
      pickWidget = const Text('Новый документ');
    }
    if (index == 3) {
      mainTitle = 'Панель\nадминистратора';
      pickWidget = const AdminUsersMainInfo();
    }
    notifyListeners();
  }
}

class MainAdminInherit extends InheritedWidget {
  final MainAdminModel model;
  const MainAdminInherit(
      {super.key, required this.model, required super.child});

  static MainAdminModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MainAdminInherit>()
        ?.model;
  }

  @override
  bool updateShouldNotify(MainAdminInherit oldWidget) {
    return model != oldWidget.model;
  }
}
