import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/login/sign_up_text_group.dart';

import '../sign_up/sign_up_input.dart';
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

  bool erPassword = false, erPhone = false;

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
            onChanged: (phone){
              LoginModelInherit.of(context)?.putUserPhone(phone: phone);
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            controller: _contPassword,
            decoration: SignUpInput(
                erText: erTextPassword,
                hintText: 'Введите пароль',
                ifError: LoginModelInherit.of(context)?.erPassword ?? false).inputDecor,
            cursorColor: mySet.main,
            onChanged: (password){
              LoginModelInherit.of(context)?.putPassword(password: password);
              setState(() {});
            },
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