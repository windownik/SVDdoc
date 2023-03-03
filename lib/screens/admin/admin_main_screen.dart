import 'package:flutter/material.dart';

import 'admin_main_screen/admin_app_bar/bottom_admin_bar.dart';
import 'admin_main_screen/admin_app_bar/small_top_btn_bar.dart';
import 'admin_main_screen/body/admin_body_users/admin_new_users.dart';
import 'admin_main_screen/admin_app_bar/font_top_bar.dart';
import 'package:svd_doc/logic/global_const.dart';

import 'main_admin_inherit.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MainAdminInherit(
      model: MainAdminModel(),
      child: const MainAdminScaffold(),
    );
  }
}

class MainAdminScaffold extends StatefulWidget{
  const MainAdminScaffold({super.key});

  @override
  State<MainAdminScaffold> createState() => _MainAdminScaffoldState();
}

class _MainAdminScaffoldState extends State<MainAdminScaffold> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = MainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainAdminWidget(
      bodyWidget: MainAdminInherit.of(context)?.pickWidget ?? const AdminUsersMainInfo(),
      showBottomBar: MainAdminInherit.of(context)?.showBottomBar ?? true,
      showLittleTopBar: MainAdminInherit.of(context)?.showLittleTopBar ?? true,
    );
  }
}

class MainAdminWidget extends StatelessWidget{
  const MainAdminWidget({
    super.key,
    required this.bodyWidget,
    this.showLittleTopBar = true,
    this.showBottomBar = true,
  });

  final bool showLittleTopBar;
  final bool showBottomBar;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(showLittleTopBar ? 173 : 122),
        child: showLittleTopBar ?
        Column(
          children: const [
            FontTopBar(),
            SmallAdminBar()
          ],
        ) : const FontTopBar(),
      ),
      bottomNavigationBar: showBottomBar ? const AdminMainBottomNavigationBar() : null,
      body: bodyWidget,
    );
  }
}