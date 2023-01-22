

import 'package:flutter/cupertino.dart';
import '../../global_const.dart';

class FirstNextSignUpButton extends StatefulWidget{
  const FirstNextSignUpButton({super.key});

  @override
  State<StatefulWidget> createState() => FirstNextSignUpButtonState();
}

class FirstNextSignUpButtonState extends State<FirstNextSignUpButton>{
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
            boxShadow: const [BoxShadow(
              color: mySet.input,
              blurRadius: 4.0,
              spreadRadius: 4.0,
              // offset: const Offset(-5, 5),
            )]
        ),
        // decoration: ,
        child: const Text(
          'Далее',
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