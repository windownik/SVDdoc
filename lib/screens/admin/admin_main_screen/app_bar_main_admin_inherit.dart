import 'package:flutter/cupertino.dart';

class AppBarMainAdminModel extends ChangeNotifier {
  bool showTopBar = true, showBottomBar = true;
  bool companyActive = false, usersActive = true, objectActive = false;
  bool lineActive = false,
      archiveActive = false,
      newDocActive = false,
      adminActive = true;
  String mainTitle = 'Панель\nадминистратора';
  String activeScreen = 'admin';

  void pickItem(int index) {
    if (index == 0) {
      activateLine();
    }
    if (index == 1) {
      activateArchive();
    }
    if (index == 2) {
      activateNewDoc();
    }
    if (index == 3) {
      activateAdmin();
    }
  }

  //------------------------
  //Активируем Элементы верхнего бара
  //------------------------
  //Активируем Пользователи в верхнем баре
  void activateUsers() {
    topFalse();
    activeScreen = 'admin';
    usersActive = true;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }

  //Активируем Редактор юр.лиц в верхнем баре
  void activateCompany() {
    topFalse();
    activeScreen = 'admin';
    companyActive = true;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }

  //Активируем Редактор объектов в верхнем баре
  void activateObject() {
    topFalse();
    activeScreen = 'admin';
    objectActive = true;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }
  //------------------------
  //Активируем Элементы нижнего бара
  //------------------------
  //Активируем Активные в нижнем баре
  void activateLine() {
    allFalse();
    activeScreen = 'line';
    lineActive = true;
    showTopBar = false;
    mainTitle = 'Документы\nна согласование';
    notifyListeners();
  }

  //Активируем Архив в нижнем баре
  void activateArchive() {
    allFalse();
    activeScreen = 'archive';
    showTopBar = false;
    archiveActive = true;
    mainTitle = 'Архив\nсогласованных докуметов';
    notifyListeners();
  }

  //Активируем Создать Новый Документ в нижнем баре
  void activateNewDoc() {
    allFalse();
    activeScreen = 'new_doc';
    showTopBar = false;
    newDocActive = true;
    mainTitle = 'Новый документ';
    notifyListeners();
  }

  //Активируем Админ в нижнем баре
  void activateAdmin() {
    allFalse();
    activeScreen = 'admin';
    showTopBar = true;
    adminActive = true;
    usersActive = true;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }

  void allFalse() {
    companyActive = false;
    usersActive = false;
    objectActive = false;
    lineActive = false;
    archiveActive = false;
    newDocActive = false;
    adminActive = false;
  }

  void topFalse() {
    companyActive = false;
    usersActive = false;
    objectActive = false;
  }

}

class AppBarMainAdminInherit extends InheritedWidget {
  final AppBarMainAdminModel model;
  const AppBarMainAdminInherit(
      {super.key, required this.model, required super.child});

  static AppBarMainAdminModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppBarMainAdminInherit>()
        ?.model;
  }

  @override
  bool updateShouldNotify(AppBarMainAdminInherit oldWidget) {
    return model != oldWidget.model;
  }
}
