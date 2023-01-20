
import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';

import 'bottom_text_group.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 117,),
                Image.asset('assets/big_icons/main_logo_border.png', height: 137, width: 163,),
                const SizedBox(height: 61,),
                Text(
                    'Пожалуйста, войдите или',
                    style: TextStyle(
                        color: mySet.input,
                        fontSize: 20,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400),
                  ),
                Text(
                  'зарегистрируйтесь, чтобы',
                  style: TextStyle(
                      color: mySet.input,
                      fontSize: 20,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'продолжить',
                  style: TextStyle(
                      color: mySet.input,
                      fontSize: 20,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50,),
                const LoginButton(),
                const SizedBox(height: 20,),
                const SignUpButton()
              ],
            ),
          ),
          const Positioned(bottom: 0, child: BottomText()),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget{
  const LoginButton({super.key});

  @override
  State<StatefulWidget> createState() => LoginButtonState();
}

class LoginButtonState extends State<LoginButton>{
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        pres = true; setState(() { });
      },
      onTapUp: (tap) {
        pres = false; setState(() { });
      },
      onTapCancel: () {
        pres = false; setState(() { });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: 44,
        decoration: BoxDecoration(
          color: pres ? mySet.second : mySet.main,
          boxShadow: [BoxShadow(
            color: mySet.input,
            blurRadius: 4.0,
            spreadRadius: 4.0,
            // offset: const Offset(-5, 5),
          )]
        ),
        // decoration: ,
        child: Text(
          'Вход',
          style: TextStyle(
              color: mySet.white,
              fontSize: 16,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class SignUpButton extends StatefulWidget{
  const SignUpButton({super.key});

  @override
  State<StatefulWidget> createState() => SignUpButtonState();
}

class SignUpButtonState extends State<SignUpButton>{
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        pres = true; setState(() { });
      },
      onTapUp: (tap) {
        pres = false; setState(() { });
      },
      onTapCancel: () {
        pres = false; setState(() { });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: 44,
        decoration: BoxDecoration(
            color: pres ? mySet.shadow : mySet.white,
            boxShadow: [BoxShadow(
              color: mySet.input,
              blurRadius: 4.0,
              spreadRadius: 4.0,
              // offset: const Offset(-5, 5),
            )]
        ),
        // decoration: ,
        child: Text(
          'Регистрация',
          style: TextStyle(
              color: mySet.main,
              fontSize: 16,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}