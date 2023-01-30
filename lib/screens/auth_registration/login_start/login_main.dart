
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/login_start/sign_up_button.dart';

import 'bottom_text_group.dart';
import 'login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mySet.background,
      body: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 117,),
                    Image.asset('assets/big_icons/main_logo_border.png', height: 137, width: 163,),
                    const SizedBox(height: 61,),
                    const Text(
                        'Пожалуйста, войдите или',
                        style: TextStyle(
                            color: mySet.input,
                            fontSize: 18,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400),
                      ),
                    const Text(
                      'зарегистрируйтесь, что бы',
                      style: TextStyle(
                          color: mySet.input,
                          fontSize: 18,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      'продолжить',
                      style: TextStyle(
                          color: mySet.input,
                          fontSize: 18,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 50,),
                    const LoginButton(),
                    const SizedBox(height: 20,),
                    const SignUpButton(),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
              const Positioned(bottom: 0, child: BottomText()),
            ],
          ),
    );
  }
}
