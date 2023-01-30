
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class ForgotPasswordBtn extends StatefulWidget{
  const ForgotPasswordBtn({super.key});

  @override
  State<ForgotPasswordBtn> createState() => _ForgotPasswordBtnState();
}

class _ForgotPasswordBtnState extends State<ForgotPasswordBtn> {
  bool pres = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          print('Forgot password');
          },
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
          alignment: Alignment.centerLeft,
          width: screenWidth,
          height: 20,
          color: pres ? mySet.shadow : Colors.transparent,
          child: const Text(
            'Забыли пароль?',
            style: TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline
            ),
          ),
        ),
    );
  }
}