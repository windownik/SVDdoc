
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/global_const.dart';

class GoodCheckIn extends StatelessWidget{
  const GoodCheckIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 280,
        width: 298,
        color: mySet.white,
        child: Column(
          children: [
            const SizedBox(height: 14,),
            SvgPicture.asset(
          'assets/svg/good_check_in.svg',
          semanticsLabel: 'Acme Logo'),
            const SizedBox(height: 19,),
            const Text('Благодарим за регистрацию!', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600)),
            const SizedBox(height: 19,),
            const Text('Администратор проверит', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const Text('введённые данные и утвердит', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const Text('вашу должность.', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const SizedBox(height: 15,),
            const Text('Вы получите уведомление!', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const SizedBox(height: 23,),
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
