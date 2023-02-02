
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';

import '../../../logic/api.dart';
import 'app_bar_main_admin_inherit.dart';

class LineAdminMainInfo extends StatefulWidget{
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
            const SizedBox(height: 50,),
            const Text('Отличная работа!', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)
            ),
            const SizedBox(height: 13,),
            const Text('Все документы согласованы', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)
            ),
            const SizedBox(height: 10,),
            Image.asset('assets/big_icons/active_empty.png', height: 200, width: 200,)
          ],
        ),
      ),
    );
  }
}


//-----------------
//Админ тело основоного экрана
class AdminUsersMainInfo extends StatefulWidget{
  const AdminUsersMainInfo({super.key});
  @override
  State<AdminUsersMainInfo> createState() => _AdminMainInfoState();
}

class _AdminMainInfoState extends State<AdminUsersMainInfo> {
  final ApiSVD api = ApiSVD();
  List newUsers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiNewUsers();
  }

  void getApiNewUsers() async {
    newUsers = await api.getUsers();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    if (newUsers.isEmpty == false) {
      return Text('Количество новых пользователей ${newUsers.length}');
    }
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text('Отличная работа!', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)
            ),
            const SizedBox(height: 13,),
            const Text('Все документы согласованы', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)
            ),
            const SizedBox(height: 10,),
            Image.asset('assets/big_icons/active_empty.png', height: 200, width: 200,)
          ],
        ),
      ),
    );
  }
}