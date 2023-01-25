import 'package:flutter/cupertino.dart';

List<String> phoneValidation(String phone) {
  List<String> returnDefault(String phone) {
    return [
      'Обязательно для ввода',
      phone
    ];
  }

  if (phone.isEmpty) return returnDefault(phone);
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
  if (goodSights.contains(phone.substring(length - 1, length))) {
    return returnDefault(phone);
  } else {
    return [
      'Допустим ввод только цифр',
      phone.substring(0, length - 1)
    ];
  }
}

bool signUpFirstValidation(
    TextEditingController contName, contSurName, contPhone) {

  return true;
}
