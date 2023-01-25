
import 'package:svd_doc/sign_up/sign_up_input.dart';

List<dynamic> phoneValidation (String phone) {
  List<dynamic> returnDefault(String phone) {
    return [
      SignUpInput(
          erText: 'Обязательно для ввода',
          hintText: 'Введите номер телефона',
          ifError: false),
      phone
    ];
  }
  if (phone.isEmpty) return returnDefault(phone);
  if (phone.startsWith('+') == false) {
    phone = "+$phone";
  }
  int length = phone.length;
  List<String> goodSights = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+',];
  if (goodSights.contains(phone.substring(length-1, length))) {
    return returnDefault(phone);
  } else {
    return [SignUpInput(
        erText: 'Допустим ввод только цифр',
        hintText: 'Введите номер телефона',
        ifError: true), phone.substring(0, length-1)];
  }
}