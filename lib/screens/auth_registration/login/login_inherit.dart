import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  String phone = '', password = '';
  String erTextPhone= 'Обязательно для ввода';
  String erTextPassword= 'Обязательно для ввода';
  bool erPassword = false, erPhone = false;
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

  void check() {
    erPassword = password.isEmpty ? true : false;
    erPhone = phone.isEmpty ? true : false;

    notifyListeners();
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
