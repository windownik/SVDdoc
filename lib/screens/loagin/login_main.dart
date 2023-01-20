
import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';
import 'package:svd_doc/screens/loagin/sign_up_button.dart';

import 'bottom_text_group.dart';
import 'login_button.dart';

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
