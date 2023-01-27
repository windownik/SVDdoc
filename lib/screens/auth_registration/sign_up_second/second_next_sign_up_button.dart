

import 'package:flutter/cupertino.dart';
import 'package:svd_doc/screens/auth_registration/sign_up/sign_up_inherith.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/sign_up_second_inherit.dart';

import 'package:svd_doc/logic/global_const.dart';

class SecondNextSignUpButton extends StatefulWidget{
  const SecondNextSignUpButton({super.key});

  @override
  State<StatefulWidget> createState() => SecondNextSignUpButtonState();
}

class SecondNextSignUpButtonState extends State<SecondNextSignUpButton>{
  bool pres = false;
  String name = '', surname = '', phone = '';


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final model = SignUpFirstInherited.of(context);
    model?.addListener(() {
      name = model.name;
      surname = model.surname;
      phone = model.phone;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        pres = true;
        setState(() { });
      },
      onTapUp: (tap) {
        bool status = SignUpSecondInherited.of(context)?.check() ?? false;
        print(status);
        if (status) {

        }
        pres = false;
        setState(() { });
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
              offset: Offset(-3.0, 3.0),
              color: mySet.shadow,
              blurRadius: 4.0,
              spreadRadius: 4.0,
              // offset: const Offset(-5, 5),
            )]
        ),
        // decoration: ,
        child: const Text(
          'Зарегистрироваться',
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