import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';
import 'package:svd_doc/screens/sign_up/sign_up_inherith.dart';
import 'package:svd_doc/screens/sign_up/sign_up_input.dart';
import 'package:svd_doc/screens/sign_up/sign_up_validation.dart';

import 'next_button.dart';


class SignUpFirstInputBar extends StatefulWidget{
  const SignUpFirstInputBar({super.key});

  @override
  State<SignUpFirstInputBar> createState() => _CustomInputBarState();
}

class _CustomInputBarState extends State<SignUpFirstInputBar> {
  final _contName = TextEditingController();
  final _contSurName = TextEditingController();
  final _contPhone = TextEditingController();

  bool erName= false;
  bool erSurname= false;
  bool erPhone= false;

  String erTextName= 'Обязательно для ввода';
  String erTextSurname= 'Обязательно для ввода';
  String erTextPhone= 'Обязательно для ввода';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = SignUpFirstInherited.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          Image.asset(
            'assets/big_icons/sign_up.png',
            height: 105,
            width: 105,
          ),
          const SizedBox(
            height: 11,
          ),
          const Text(
            'Регистрация',
            style: TextStyle(
                color: mySet.main,
                fontSize: 28,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'шаг 1 из 2',
            style: TextStyle(
                color: mySet.input,
                fontSize: 20,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Пожалуйста, введите свои данные',
            style: TextStyle(
                color: mySet.input,
                fontSize: 20,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _contName,
            decoration: SignUpInput(
                erText: erTextName,
                hintText: 'Введите имя',
                ifError: SignUpFirstInherited.of(context)?.erName ?? false).inputDecor,
            cursorColor: mySet.main,
            onChanged: (name){
              SignUpFirstInherited.of(context)?.putUserName(name: name);
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            controller: _contSurName,
            decoration: SignUpInput(
                erText: erTextName,
                hintText: 'Введите фамилию',
                ifError: SignUpFirstInherited.of(context)?.erSurname ?? false).inputDecor,
            cursorColor: mySet.main,
            onChanged: (surname){
              SignUpFirstInherited.of(context)?.putUserSurname(surname: surname);
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            onTap: () {
              if (_contPhone.text.isEmpty) {
                _contPhone.text = '+';
              }
            },
            keyboardType:
            const TextInputType.numberWithOptions(decimal: true),

            onChanged: (phone) {
              phoneValidation(phone, context);
              phone = SignUpFirstInherited.of(context)?.phone ?? '';
              _contPhone.text = phone;
              _contPhone.selection = TextSelection.fromPosition(
                  TextPosition(offset: phone.length));

              setState(() {});
            },
            controller: _contPhone,
            decoration: SignUpInput(
                erText: SignUpFirstInherited.of(context)?.erTextPhone ?? erTextPhone,
                hintText: 'Введите номер телефона',
                ifError: SignUpFirstInherited.of(context)?.erPhone ?? false).inputDecor,
            cursorColor: mySet.main,
          ),
          const SizedBox(
            height: 35,
          ),
          const FirstNextSignUpButton()
        ],
      ),
    );
  }
}