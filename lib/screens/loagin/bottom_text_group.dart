
import 'package:flutter/material.dart';
import '../../global_const.dart';

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
                  Text(
                    'или',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 18,
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
              Text(
                'Вы администратор?',
                style: TextStyle(
                    color: mySet.input,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
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
                  color: pres ? mySet.shadow : Colors.transparent,
                  child: Text(
                    'Зарегистрируйтесь',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 18,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w500,
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