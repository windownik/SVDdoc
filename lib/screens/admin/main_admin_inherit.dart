import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'admin_main_screen/body/admin_body_users/admin_new_users.dart';
import 'admin_main_screen/body/admin_body_users/new_user_screen.dart';
import 'admin_main_screen/body/admin_company_body/add_user_to_company.dart';
import 'admin_main_screen/body/admin_company_body/company_dody.dart';
import 'admin_main_screen/body/admin_company_body/new_company_body/new_company_body.dart';
import 'admin_main_screen/body/admin_line_body/admin_line_body.dart';
import 'admin_main_screen/body/objects_admin_body/object_admin_body.dart';
import 'admin_main_screen/body/objects_admin_body/objects_of_one_company/objects_of_one _company_screen.dart';
import 'create_new_doc_screen/new_doc_start_body/new_doc_start_screen.dart';

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
  List<User> usersCompanyLine = [];

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

  void setAddNewUserToCompanyWidgetToBody(Company company) {
    pickWidget = AddUserToCompany(company: company,);
    showBottomBar = false;
    showLittleTopBar = false;
    backIcon = true;
    mainTitle = 'Добавить\nсотрудника';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    backOnPressed = () {
      setNewCompanyWidgetToBody(company);
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
    showLittleTopBar = false;
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
    topActiveBtn = 0;
    mainTitle = 'Панель\nадминистратора';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }
  // Создаем новую компанию / Редактируем компанию
  void setNewCompanyWidgetToBody([Company? company]) async {
    allUsersCompany.clear();
    pickWidget = NewCompanyAdminBody(company: company);
    showBottomBar = false;
    showLittleTopBar = false;
    backIcon = true;
    backOnPressed = () {
      setAllCompanyListWidgetToBody();
    };
    topActiveBtn = 0;
    mainTitle = 'Новое\nюридическое лицо';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
    if (company != null) {
      updateAllUsersCompany(company.companyId);
    }
  }

  //-----------------------
  // Работаем с объектами
  //-----------------------
  // Стартовые объекты
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

  // Стартовый объекты поиск по компании
  void setObjectsOfOneCompanyWidgetToBody(Company company) {
    pickWidget = AllObjectOfOneCompanyBody(company: company);
    showBottomBar = true;
    showLittleTopBar = false;
    backIcon = true;
    backOnPressed = () {
      setObjectAdminWidgetToBody();
    };
    topActiveBtn = 2;
    mainTitle = 'Панель объектов';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  void updateAllUsersCompany(int companyId) async {
    allUsersCompany.clear();
    allUsersCompany = await api.getCompanyLineUsers(companyId);
    notifyListeners();
  }

  void insertAllUsersCompany(List<User> allUsers) async {
    allUsersCompany.clear();
    allUsersCompany = allUsers;
    notifyListeners();
  }

  void insertUsersCompanyLine(List<User> usersCompanyLine) async {
    this.usersCompanyLine.clear();
    this.usersCompanyLine = usersCompanyLine;
    notifyListeners();
  }

  //-----------------------
  // Работаем с объектами
  //-----------------------
  // Стартовый объекты
  void setNewDocStartWidgetToBody() {
    pickWidget = const NewDocStartScreen();
    showBottomBar = true;
    showLittleTopBar = false;
    backIcon = false;
    topActiveBtn = 2;
    mainTitle = 'Панель объектов';
    assetsImageFont = 'assets/app_bar/admin_main.png';
    notifyListeners();
  }

  //------------------------
  // Активируем Элементы верхнего бара
  //------------------------
  void updateTopItem(int index) {
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
      // List data = ['1', '2', '3', '4', '5', '6'];
      showLittleTopBar = true;
      mainTitle = 'Архив\nсогласованных докуметов';
      pickWidget = const Center(child: Text('Архив', style:
      TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
      ));
      //     ReorderableListView(
      //     children: [
      //       for (var one in data) Container(
      //           key: ValueKey(one),
      //           color: mySet.red,
      //           child: Text(one)),
      //     ],
      //     onReorder: (oldWidget, newWidget) {
      //     }
      // );
    }
    if (index == 2) {
      showLittleTopBar = false;
      mainTitle = 'Новый документ';
      setNewDocStartWidgetToBody();
    }
    if (index == 3) {
      mainTitle = 'Панель\nадминистратора';
      setNewUsersWidgetToBody();
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
