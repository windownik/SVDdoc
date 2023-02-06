import 'package:flutter/cupertino.dart';

import 'body/admin_body_users/admin_new_users.dart';
import 'body/admin_main_body.dart';

class MainAdminModel extends ChangeNotifier {
  bool showLittleTopBar = true, showBottomBar = true;

  // Flags for small top btn bar
  int topActiveBtn = 2;

  //Flags for bottom admin bar
  int bottomActiveBtn = 3;
  String mainTitle = 'Панель\nадминистратора';
  Widget pickWidget = const LineAdminMainInfo();

  void updateMainTitle(String title) {
    mainTitle = title;
    notifyListeners();
  }

  //------------------------
  //Активируем Элементы верхнего бара
  //------------------------
  void pickTopItem(int index) {
    topActiveBtn = index;
    mainTitle = 'Панель\nадминистратора';
    notifyListeners();
  }

  //------------------------
  //Активируем Элементы нижнего бара
  //------------------------
  void pickBottomItem(int index) {
    bottomActiveBtn = index;
    if (index == 0) {
      mainTitle = 'Документы\nна согласование';
      pickWidget = const Text('Документы\nна согласование');
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
