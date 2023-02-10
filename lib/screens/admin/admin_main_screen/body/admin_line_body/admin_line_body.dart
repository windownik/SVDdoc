
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';


class LineAdminBody extends StatefulWidget {
  const LineAdminBody({super.key});
  @override
  State<LineAdminBody> createState() => _LineAdminBodyState();
}

class _LineAdminBodyState extends State<LineAdminBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('Отличная работа!',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 13,
            ),
            const Text('У вас на рассмотрении\nнет новых документов.',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/big_icons/active_empty.png',
              height: 200,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
