
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/global_const.dart';

class NoInetConnection extends StatelessWidget{
  const NoInetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 230,
        width: 315,
        color: mySet.white,
        child: Column(
          children: [
            const SizedBox(height: 17,),
            SvgPicture.asset(
                'assets/svg/exclamatory.svg',
                semanticsLabel: 'Acme Logo'),
            const SizedBox(height: 26,),
            const Text('Отсутствует соединение с', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600)),
            const Text('интернетом', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600)),
            const SizedBox(height: 10,),
            const Text('попробуйте еще раз', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const SizedBox(height: 27,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 30,
                width: 110,
                decoration: const BoxDecoration(
                    color: mySet.main,
                    boxShadow: [BoxShadow(
                      color: mySet.shadow,
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                      // offset: const Offset(-5, 5),
                    )]
                ),
                // decoration: ,
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
