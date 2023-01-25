

import 'package:flutter/cupertino.dart';
import 'package:svd_doc/screens/sign_up/sign_up_inherith.dart';
import '../../global_const.dart';

class FirstNextSignUpButton extends StatefulWidget{
  const FirstNextSignUpButton({super.key});

  @override
  State<StatefulWidget> createState() => FirstNextSignUpButtonState();
}

class FirstNextSignUpButtonState extends State<FirstNextSignUpButton>{
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
        SignUpFirstInherited.of(context)?.check();
        pres = true;
        setState(() { });
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
              offset: Offset(-3.0, 3.0),
              color: mySet.shadow,
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
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}