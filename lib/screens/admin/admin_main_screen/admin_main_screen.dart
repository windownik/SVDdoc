
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'app_bar_main.dart';
import 'app_bar_main_admin_inherit.dart';
import 'bottom_admin_bar.dart';
import 'package:svd_doc/logic/global_const.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  UserDataBase db = UserDataBase();

  @override
  Widget build(BuildContext context) {
    return AppBarMainAdminInherit(
      model: AppBarMainAdminModel(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(210),
          child: AppBarMainAdmin(),
        ),
        bottomNavigationBar: const AdminMainBottomNavigationBar(),
        body: getAdminBody(context, AppBarMainAdminInherit.of(context)?.getActiveScreen() ?? 'admin'),
      ),
    );
  }
}


Widget getAdminBody(context, String active) {
  if (active == 'line') return const LineAdminMain();
  return const LineAdminMain();
}


class LineAdminMain extends StatefulWidget{
  const LineAdminMain({super.key});

  @override
  State<LineAdminMain> createState() => _LineAdminMainState();
}

class _LineAdminMainState extends State<LineAdminMain> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
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
    );
  }
}