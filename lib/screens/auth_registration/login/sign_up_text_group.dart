

import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class SignUpTextGroup extends StatefulWidget {
  const SignUpTextGroup({super.key});

  @override
  State<SignUpTextGroup> createState() => _BottomTextState();
}

class _BottomTextState extends State<SignUpTextGroup> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Container(
        width: screenSize,
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
            children: [
              const Text(
                'Нет аккаунта?',
                style: TextStyle(
                    color: mySet.input,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/sign_up');
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
                  alignment: Alignment.center,
                  height: 20,
                  color: pres ? mySet.shadow : Colors.transparent,
                  child: const Text(
                    'Зарегистрируйтесь',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              )
            ],
      )
    );
  }
}