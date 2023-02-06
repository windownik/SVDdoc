
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';


class CompanyAdminBody extends StatefulWidget {
  const CompanyAdminBody({super.key});
  @override
  State<CompanyAdminBody> createState() => _CompanyAdminBodyState();
}

class _CompanyAdminBodyState extends State<CompanyAdminBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('У вас нет оргонизаций',
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
