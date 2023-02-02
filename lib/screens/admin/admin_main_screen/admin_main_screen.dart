
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'admin_main_body.dart';
import 'app_bar_main.dart';
import 'app_bar_main_admin_inherit.dart';
import 'bottom_admin_bar.dart';

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
      child: const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(210),
          child: AppBarMainAdmin(),
        ),
        bottomNavigationBar: AdminMainBottomNavigationBar(),
        body: AdminBody(),
      ),
    );
  }
}

class AdminBody extends StatefulWidget{
  const AdminBody({super.key});

  @override
  State<AdminBody> createState() => _AdminBodyState();
}

class _AdminBodyState extends State<AdminBody> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String active = AppBarMainAdminInherit.of(context)?.activeScreen ?? 'admin';
    // if (active == 'line') return const LineAdminMainInfo();
    // if (active == 'admin') return const AdminUsersMainInfo();
    // if (active == 'new_doc') return const Text('new_doc');
    return const LineAdminMainInfo();
  }
}
