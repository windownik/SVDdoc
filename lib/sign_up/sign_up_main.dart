import 'package:flutter/material.dart';
import 'package:svd_doc/sign_up/sign_up_input.dart';
import 'package:svd_doc/sign_up/sign_up_validation.dart';

import '../global_const.dart';
import 'next_button.dart';

class SignUpFirst extends StatefulWidget {
  const SignUpFirst({super.key});

  @override
  State<SignUpFirst> createState() => _SignUpFirstState();
}

class _SignUpFirstState extends State<SignUpFirst> {
  final _contName = TextEditingController();
  final _contSurName = TextEditingController();
  final _contPhone = TextEditingController();

  final SignUpInput _inputName = SignUpInput(
      erText: 'Обязательно для ввода', hintText: 'Введите имя', ifError: false);

  final SignUpInput _inputSurName = SignUpInput(
      erText: 'Обязательно для ввода',
      hintText: 'Введите фамилию',
      ifError: false);

  SignUpInput _inputPhone = SignUpInput(
      erText: 'Обязательно для ввода',
      hintText: 'Введите номер телефона',
      ifError: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySet.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
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
                    decoration: _inputName.inputDecor,
                    cursorColor: mySet.main,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextField(
                    controller: _contSurName,
                    decoration: _inputSurName.inputDecor,
                    cursorColor: mySet.main,
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
                      List<dynamic> resp = phoneValidation(phone);
                      _inputPhone = resp[0];
                      _contPhone.text = resp[1];
                      _contPhone.selection =
                          TextSelection.fromPosition(
                              TextPosition(
                                  offset: _contPhone.text.length));
                      setState(() {});
                    },
                    controller: _contPhone,
                    decoration: _inputPhone.inputDecor,
                    cursorColor: mySet.main,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const FirstNextSignUpButton()
                ],
              ),
            ),
          ),
          Positioned(
              left: 10,
              top: 66,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: mySet.main,
                ),
              )),
        ],
      ),
    );
  }
}
