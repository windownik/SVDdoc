
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class BottomText extends StatefulWidget {
  const BottomText({super.key});

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          const SizedBox(height: 100,),
            SizedBox(width: screenSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: mySet.main,
                    height: 1,
                    width: screenSize * 0.35,
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  const Text(
                    'или',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w500,
                        decoration: null),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Container(
                    color: mySet.main,
                    height: 1,
                    width: screenSize * 0.35,
                  ),
                ],

          ),
            ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                'Вы администратор?',
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
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}