import 'package:flutter/cupertino.dart';

class SignUpSecondModel extends ChangeNotifier {
  String email = '',
      password = '',
      repPassword = '';
  bool erEmail = false;
  bool erPassword = false;
  bool erRepPassword = false;

  String erTextEmail = 'Не верный формат email';
  String erTextPassword = 'Обязательно для ввода';
  String erTextRepPassword = 'Обязательно для ввода';

  // All about Email
  void putEmail({
    required String email,
  }) {
    erEmail = false;
    this.email = email;
    notifyListeners();
  }

  void putErEmail({
    required bool erEmail,
  }) {
    this.erEmail = erEmail;
    notifyListeners();
  }

  void putErTextEmail({
    required String erTextEmail,
  }) {
    this.erTextEmail = erTextEmail;
    notifyListeners();
  }

  // All about Password
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

  void putErTextPassword({
    required String erTextPassword,
  }) {
    this.erTextPassword = erTextPassword;
    notifyListeners();
  }

  // All about RepPassword
  void putRepPassword({
    required String repPassword,
  }) {
    erRepPassword = false;
    this.repPassword = repPassword;
    notifyListeners();
  }

  void putErRepPassword({
    required bool erRepPassword,
  }) {
    this.erRepPassword = erRepPassword;
    notifyListeners();
  }

  void putErTextRepPassword({
    required String erTextRepPassword,
  }) {
    this.erTextRepPassword = erTextRepPassword;
    notifyListeners();
  }
  bool check() {
    //Проверяем email
    if (email.isEmpty) {
      erEmail = false;
    } else {
      //Умная проверка email
      bool status = checkEmail(email: email);
      erEmail = status;
    }
    if (password.length < 6) {
      erTextPassword = 'Минимальная длинна 6 символов';
      erPassword = true;
    } else {
      erPassword = false;
    }
    if (repPassword.length < 6) {
      erTextRepPassword = 'Минимальная длинна 6 символов';
      erRepPassword = true;
    } else {
      erRepPassword = false;
    }
    //Проверяем на запрещенные знаки
    if (!erPassword) {
      bool letters = checkPassword(password: password);
      if (!letters) {
        erTextPassword = 'Только цифры и буквы латинскго алфавита';
      }
      erPassword = !letters;
    }
    if (!erRepPassword) {
      bool letters = checkPassword(password: repPassword);
      if (!letters) {
        erTextRepPassword = 'Только цифры и буквы латинскго алфавита';
      }
      erRepPassword = !letters;
    }
    if (!erPassword && !erRepPassword) {
      if (password != repPassword) {
        erTextRepPassword = 'Не совпадает с паролем';
        erRepPassword = true;
      }
    }
    notifyListeners();
    print([erEmail, erPassword, erRepPassword]);
    print([erEmail, erPassword, erRepPassword]);
    if (!erEmail && !erPassword && !erRepPassword) {
      return true;
    } else {
      return false;
    }
  }
}

bool checkEmail ({required String email}){
  String goodLetters = 'abcdefghijklmnopqrstuvwxyz1234567890_-.@';
  for (String i in email.toLowerCase().split('')) {
    if (goodLetters.contains(i) == false) {
      return true;
    }
  }
  if (email.contains('@') == false){
    return true;
  }
  List<String> partsEmail = email.split('@');
  if (partsEmail[0].length < 2) {
    return true;
  }
  if (partsEmail[1].length < 3) {
    return true;
  }
  if (partsEmail[1].contains('.') == false) {
    return true;
  }

  if (partsEmail[1].split('.')[0].isEmpty) {
    return true;
  }
  if (partsEmail[1].split('.')[1].length < 2) {
    return true;
  }
  return false;
}

bool checkPassword ({required String password}){
  String goodLetters = 'abcdefghijklmnopqrstuvwxyz1234567890';
  for (String i in password.toLowerCase().split('')) {
    if (goodLetters.contains(i) == false) {
      return false;
    }
  }
  return true;
}

class SignUpSecondInherited extends InheritedWidget {
  final SignUpSecondModel model;

  const SignUpSecondInherited({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static SignUpSecondModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SignUpSecondInherited>()
        ?.model;
  }

  @override
  bool updateShouldNotify(SignUpSecondInherited oldWidget) {
    return model != oldWidget.model;
  }
}
