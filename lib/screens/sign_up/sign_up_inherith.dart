import 'package:flutter/cupertino.dart';

class SignUpFirstModel extends ChangeNotifier {
  String name = '', surname = '', phone = '';
  String erTextName= 'Обязательно для ввода';
  String erTextSurname= 'Обязательно для ввода';
  String erTextPhone= 'Обязательно для ввода';
  bool erName = false, erSurname = false, erPhone = false;
  void putUserPhone({
    required String phone,
  }) {
    erPhone = false;
    this.phone = phone;
  }
  void putUserName({
    required String name,
  }) {
    erName = false;
    this.name = name;
  }
  void putUserSurname({
    required String surname,
  }) {
    erSurname = false;
    this.surname = surname;
  }
  void check() {
    if (name.isEmpty) {
      erName = true;
    } else {
      erName = false;
    }
    if (surname.isEmpty) {
      erSurname = true;
    } else {
      erSurname = false;
    }
    if (phone.isEmpty) {
      erPhone = true;
    } else {
      erPhone = false;
    }
    notifyListeners();
  }
}

class SignUpFirstInherited extends InheritedWidget {
  final SignUpFirstModel model;

  const SignUpFirstInherited({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static SignUpFirstModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SignUpFirstInherited>()
        ?.model;
  }

  @override
  bool updateShouldNotify(SignUpFirstInherited oldWidget) {
    return model != oldWidget.model;
  }
}
