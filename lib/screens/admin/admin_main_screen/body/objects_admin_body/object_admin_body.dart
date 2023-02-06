
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';


class ObjectAdminBody extends StatefulWidget {
  const ObjectAdminBody({super.key});
  @override
  State<ObjectAdminBody> createState() => _ObjectAdminBodyState();
}

class _ObjectAdminBodyState extends State<ObjectAdminBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('У вас нет объектов',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
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
