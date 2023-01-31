import 'package:flutter/cupertino.dart';

import '../../../logic/api.dart';
import '../../../logic/data_base.dart';

class LoginModel extends ChangeNotifier {
  String phone = '', password = '';
  String erTextPhone= 'Обязательно для ввода';
  String erTextPassword= 'Обязательно для ввода';
  bool erPassword = false, erPhone = false;
  ApiSVD api = ApiSVD();
  void putUserPhone({
    required String phone,
  }) {
    erPhone = false;
    this.phone = phone;
    notifyListeners();
  }
  void putErPhone({
    required bool erPhone,
  }) {
    this.erPhone = erPhone;
    notifyListeners();
  }

  void putPassword({
    required String password,
  }) {
    erPassword = false;
    this.password = password;
    notifyListeners();
  }

  void putErPassword({
    required bool erPassword,
  }) {
    this.erPassword = erPassword;
    notifyListeners();
  }

  Future<bool> check() async {
    erPassword = password.isEmpty ? true : false;
    erPhone = phone.isEmpty ? true : false;
    notifyListeners();
    if (erPassword && erPhone) {
      return false;
    } else {
      api.logIn(phone, password);
      User user = await api.userGet();
      print(user.userId);
      if (user.userId == 0) {
        return false;
      }
      return true;
    }
  }
}

class LoginModelInherit extends InheritedWidget {
  final LoginModel model;

  const LoginModelInherit({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static LoginModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoginModelInherit>()
        ?.model;
  }

  @override
  bool updateShouldNotify(LoginModelInherit oldWidget) {
    return model != oldWidget.model;
  }
}
