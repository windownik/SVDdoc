import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/login/sign_up_text_group.dart';

import '../sign_up/sign_up_input.dart';
import '../sign_up/sign_up_validation.dart';
import 'forgot_password_btn.dart';
import 'login_btn.dart';
import 'login_inherit.dart';



class LoginInputBar extends StatefulWidget{
  const LoginInputBar({super.key});

  @override
  State<LoginInputBar> createState() => _LoginInputBarState();
}

class _LoginInputBarState extends State<LoginInputBar> {
  final _contPassword = TextEditingController();
  final _contPhone = TextEditingController();

  bool erPassword = false, erPhone = false, showPas = false;

  String erTextPassword= 'Обязательно для ввода';
  String erTextPhone= 'Обязательно для ввода';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = LoginModelInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenSize,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          Image.asset(
            'assets/big_icons/login.png',
            height: 110,
            width: 192,
          ),
          const SizedBox(
            height: 11,
          ),
          const Text(
            'Вход',
            style: TextStyle(
                color: mySet.main,
                fontSize: 28,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Пожалуйста, введите свой адрес',
            style: TextStyle(
                color: mySet.input,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const Text(
            'электронной почты и пароль',
            style: TextStyle(
                color: mySet.input,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _contPhone,
            decoration: SignUpInput(
                erText: erTextPhone,
                hintText: 'Введите номер телефона',
                ifError: LoginModelInherit.of(context)?.erPhone ?? false).inputDecor,
            cursorColor: mySet.main,
            keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
            onTap: () {
              if (_contPhone.text.isEmpty) {
                _contPhone.text = '+';
              }
            },
            onChanged: (phone){
              String goodLine = '0123456789+';
              if (!goodLine.contains(phone.substring(phone.length -1, phone.length))) {
                _contPhone.text = phone.substring(0, phone.length-1);
                _contPhone.selection = TextSelection.fromPosition(
                        TextPosition(offset: phone.length-1));
              } else {
                LoginModelInherit.of(context)?.putUserPhone(phone: phone);
              }
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            onChanged: (password) {
              LoginModelInherit.of(context)?.putPassword(password: password);
              setState(() {});
            },
            obscureText: showPas,
            controller: _contPassword,
            decoration: PasswordInput(
                erText: erTextPassword,
                hintText: 'Введите пароль',
                ifError: LoginModelInherit.of(context)?.erPassword ?? false,
                icon: Icon(showPas
                    ? Icons.visibility_off
                    : Icons.visibility, color: mySet.input,),
                onPressed: () {
                  showPas = !showPas;
                  setState(() {});
                }).inputDecor,
            cursorColor: mySet.main,
          ),
          const SizedBox(
            height: 18,
          ),
          const ForgotPasswordBtn(),
          const SizedBox(
            height: 37,
          ),
          const LoginBtn(),
          const SizedBox(
            height: 20,
          ),
          const SignUpTextGroup()
        ],
      ),
    );
  }
}