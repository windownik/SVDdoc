import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'admin_main_body.dart';
import 'app_bar_main.dart';
import 'app_bar_main_admin_inherit.dart';
import 'package:svd_doc/logic/global_const.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  UserDataBase db = UserDataBase();

  int index = 3;

  var mainAdminBody= {
    0: const LineAdminMainInfo(),
    1: const Text('archive'),
    2: const Text('new_doc'),
    3: const AdminUsersMainInfo(),
  };

  void pickItem(int newIndex) {
    index = newIndex;
    AppBarMainAdminInherit.of(context)?.pickItem(newIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = 100;
    if (Platform.isAndroid) {
      bottomBarHeight = 75;
    } else if (Platform.isIOS) {
      bottomBarHeight = 100;
    }
    return AppBarMainAdminInherit(
      model: AppBarMainAdminModel(),

      child: Scaffold(
        backgroundColor: mySet.background,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(210),
          child: AppBarMainAdmin(),
        ),
        bottomNavigationBar: SizedBox(
          height: bottomBarHeight,
          child: BottomNavigationBar(
            onTap: (newIndex) {
              pickItem(newIndex);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: mySet.main,
            currentIndex: index,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            selectedItemColor: mySet.white,
            unselectedItemColor: mySet.second,
            selectedIconTheme: const IconThemeData(color: mySet.white, size: 35),
            unselectedIconTheme:
            const IconThemeData(color: mySet.unSelect, size: 35),
            // selectedItemColor: mySet.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_bar_active.svg',
                  semanticsLabel: 'Acme Logo',
                  color: index == 0 ? mySet.white : mySet.second,
                ),
                label: 'Активные',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_bar_archive.svg',
                  semanticsLabel: 'Acme Logo',
                  color: index == 1 ? mySet.white : mySet.second,
                ),
                label: 'Архив',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_bar_new_doc.svg',
                  semanticsLabel: 'Acme Logo',
                  color: index == 2 ? mySet.white : mySet.second,
                ),
                label: 'Создать',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_bar_admin.svg',
                  semanticsLabel: 'Acme Logo',
                  color: index == 3 ? mySet.white : mySet.second,
                ),
                label: 'Админ',
              ),
            ],
          ),
        ),
        body: mainAdminBody[index] ?? const LineAdminMainInfo(),
      ),
    );
  }
}
