
import 'package:flutter/cupertino.dart';
import '../../global_const.dart';

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