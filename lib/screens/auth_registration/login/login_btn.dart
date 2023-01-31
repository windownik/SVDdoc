
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/global_const.dart';

import 'login_inherit.dart';

class LoginBtn extends StatefulWidget{
  const LoginBtn({super.key});

  @override
  State<StatefulWidget> createState() => LoginButtonState();
}

class LoginButtonState extends State<LoginBtn>{
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          bool status = await LoginModelInherit.of(context)?.check() ?? false;
          print(status);
          if (status) {
            Navigator.of(context).popAndPushNamed('/admin_start');
          }
        } catch (e){
          print([1, e]);
        }
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
        // margin: const EdgeInsets.only(left: 20, right: 20),
        height: 47,
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
          'Войти',
          style: TextStyle(
              color: mySet.white,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
