
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';


class LineAdminMainInfo extends StatefulWidget {
  const LineAdminMainInfo({super.key});
  @override
  State<LineAdminMainInfo> createState() => _LineAdminMainInfoState();
}

class _LineAdminMainInfoState extends State<LineAdminMainInfo> {
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
            const Text('Новые пользователи отсутствуют.',
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
