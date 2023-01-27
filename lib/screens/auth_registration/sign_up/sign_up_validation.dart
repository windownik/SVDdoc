import 'package:svd_doc/screens/auth_registration/sign_up/sign_up_inherith.dart';

import 'package:svd_doc/logic/data_base.dart';

bool phoneValidation(String phone, var context) {
  void returnDefault(String phone) {
    SignUpFirstInherited.of(context)
        ?.putErTextPhone(erTextPhone: 'Обязательно для ввода');
    SignUpFirstInherited.of(context)?.putUserPhone(phone: phone);
  }

  if (phone.isEmpty) {
    returnDefault(phone);
    return true;
  }

  if (phone.startsWith('+') == false) {
    phone = "+$phone";
  }
  int length = phone.length;
  List<String> goodSights = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '+',
  ];
  if (phone.length > 14) {
    SignUpFirstInherited.of(context)
        ?.putErTextPhone(erTextPhone: 'Номер слишком длинный');
    SignUpFirstInherited.of(context)
        ?.putUserPhone(phone: phone.substring(0, length - 1));
    SignUpFirstInherited.of(context)?.putErPhone(erPhone: true);
    return true;
  }

  if (goodSights.contains(phone.substring(length - 1, length))) {
    returnDefault(phone);
    return true;
  } else {
    SignUpFirstInherited.of(context)
        ?.putErTextPhone(erTextPhone: 'Допустим ввод только цифр');
    SignUpFirstInherited.of(context)
        ?.putUserPhone(phone: phone.substring(0, length - 1));
    SignUpFirstInherited.of(context)?.putErPhone(erPhone: true);
    return true;
  }
}

bool signUpFirstValidation(context,
    {required String name, required String surName, required String phone}) {
  if (name.isEmpty) return false;
  if (surName.isEmpty) return false;
  if (phone.isEmpty) return false;
  if (phone.length > 14) {
    SignUpFirstInherited.of(context)
        ?.putErTextPhone(erTextPhone: 'Номер слишком длинный');
    return false;
  }
  List<String> goodSights = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '+',
  ];

  for (var i in phone.split('')) {
    if (goodSights.contains(i) == false) {
      SignUpFirstInherited.of(context)
          ?.putErTextPhone(erTextPhone: 'Допустим ввод только цифр');
      return false;
    }
  }
  phone = phone.substring(1, phone.length);
  UserDataBase db = UserDataBase();
  db.writeName(name);
  db.writeSurName(surName);
  db.writePhone(int.parse(phone));
  return true;
}
