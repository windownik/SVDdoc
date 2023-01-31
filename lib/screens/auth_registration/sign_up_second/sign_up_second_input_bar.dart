import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/sign_up/sign_up_input.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/second_next_sign_up_button.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/sign_up_second_inherit.dart';




class SignUpSecondInputBar extends StatefulWidget{
  const SignUpSecondInputBar({super.key});

  @override
  State<SignUpSecondInputBar> createState() => _CustomInputBarState();
}

class _CustomInputBarState extends State<SignUpSecondInputBar> {
  final _contEmail = TextEditingController();
  final _contPassword = TextEditingController();
  final _contRepPassword = TextEditingController();

  bool erEmail= false;
  bool erPassword= false;
  bool erRepPassword= false;
  bool visibilityPas= true;
  bool visibilityRepPas= true;

  String erTextEmail = 'Не верный формат email';
  String erTexPassword = 'Обязательно для ввода';
  String erTextRepPassword = 'Обязательно для ввода';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = SignUpSecondInherited.of(context);
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
            'шаг 2 из 2',
            style: TextStyle(
                color: mySet.input,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Пожалуйста, введите адрес ',
            style: TextStyle(
                color: mySet.input,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const Text(
            'электронной почты и пароль ',
            style: TextStyle(
                color: mySet.input,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(right: 0, left: 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Поле не обязательно для заполнения',
              style: TextStyle(
                  color: mySet.input,
                  fontSize: 14,
                  fontFamily: "Italic",
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _contEmail,
            decoration: SignUpInput(
                erText: erTextEmail,
                hintText: 'Введите e-mail',
                ifError: SignUpSecondInherited.of(context)?.erEmail ?? false).inputDecor,
            cursorColor: mySet.main,
            onChanged: (email){
              SignUpSecondInherited.of(context)?.putEmail(email: email);
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            obscureText: visibilityPas,
            controller: _contPassword,
            decoration: PasswordInput(
                erText: SignUpSecondInherited.of(context)?.erTextPassword ?? erTexPassword,
                hintText: 'Введите пароль',
                ifError: SignUpSecondInherited.of(context)?.erPassword ?? false,
                icon: Icon(visibilityPas
                    ? Icons.visibility_off
                    : Icons.visibility, color: mySet.input),
                onPressed: () {
                  visibilityPas = !visibilityPas;
                  setState(() {});
                }).inputDecor,
            cursorColor: mySet.main,
            onChanged: (password){
              SignUpSecondInherited.of(context)?.putPassword(password: password);
              setState(() {});
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextField(
            onChanged: (repPassword) {
              SignUpSecondInherited.of(context)?.putRepPassword(repPassword: repPassword);
              setState(() {});
            },
            obscureText: visibilityRepPas,
            controller: _contRepPassword,
            decoration: PasswordInput(
                erText: SignUpSecondInherited.of(context)?.erTextRepPassword ?? erTextRepPassword,
                hintText: 'Подтвердите пароль',
                ifError: SignUpSecondInherited.of(context)?.erRepPassword ?? false,
                icon: Icon(visibilityRepPas
                    ? Icons.visibility_off
                    : Icons.visibility, color: mySet.input,),
                onPressed: () {
                  visibilityRepPas = !visibilityRepPas;
                  setState(() {});
                }).inputDecor,
            cursorColor: mySet.main,
          ),
          const SizedBox(
            height: 35,
          ),
          const SecondNextSignUpButton()
        ],
      ),
    );
  }
}