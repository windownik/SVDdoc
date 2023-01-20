

import 'package:flutter/cupertino.dart';
import '../../global_const.dart';

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