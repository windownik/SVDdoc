import 'package:flutter/cupertino.dart';

class SignUpSecondModel extends ChangeNotifier {
  String email = '',
      password = '',
      repPassword = '';
  bool erEmail = false;
  bool erPassword = false;
  bool erRepPassword = false;

  String erTextEmail = '';
  String erTextPassword = 'Обязательно для ввода';
  String erTextRepPassword = 'Обязательно для ввода';

  // All about Email
  void putEmail({
    required String email,
  }) {
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
}
//   void check() {
//     if (email.isEmpty) {
//       erEmail = false;
//     } else {
//       erEmail = false;
//     }
//     if (password.isEmpty) {
//       erSurname = true;
//     } else {
//       erSurname = false;
//     }
//     if (phone.isEmpty) {
//       erPhone = true;
//     } else {
//       erPhone = false;
//     }
//
//     notifyListeners();
//   }
// }
//
// bool checkEmail ({required String email}){
//
// }

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
