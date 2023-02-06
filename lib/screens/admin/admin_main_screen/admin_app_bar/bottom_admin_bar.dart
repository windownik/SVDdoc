
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/main_admin_inherit.dart';


class AdminMainBottomNavigationBar extends StatefulWidget {
  const AdminMainBottomNavigationBar({super.key});

  @override
  State<AdminMainBottomNavigationBar> createState() => _AdminMainBottomNavigationBarState();
}

class _AdminMainBottomNavigationBarState extends State<AdminMainBottomNavigationBar> {
  int index = 3;
  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = 100;
    if (Platform.isAndroid) {
      bottomBarHeight = 75;
    } else if (Platform.isIOS) {
      bottomBarHeight = 100;
    }

    index = MainAdminInherit.of(context)?.bottomActiveBtn ?? 3;

    return SizedBox(
      height: bottomBarHeight,
      child: BottomNavigationBar(
        onTap: (newIndex) {
          MainAdminInherit.of(context)?.pickBottomItem(newIndex);
          setState(() { });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: mySet.main,
        currentIndex: index,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: mySet.white,
        unselectedItemColor: mySet.second,
        selectedIconTheme:
        const IconThemeData(color: mySet.white, size: 35),
        unselectedIconTheme:
        const IconThemeData(color: mySet.unSelect, size: 35),
        // selectedItemColor: mySet.white,
        items: <BottomNavigationBarItem>[
          // Line
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_active.svg',
              semanticsLabel: 'Acme Logo',
              color: index == 0 ? mySet.white : mySet.second,
            ),
            label: 'Активные',
          ),
          // Archive
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_archive.svg',
              semanticsLabel: 'Acme Logo',
              color: index == 1 ? mySet.white : mySet.second,
            ),
            label: 'Архив',
          ),
          // Create
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_new_doc.svg',
              semanticsLabel: 'Acme Logo',
              color: index == 2 ? mySet.white : mySet.second,
            ),
            label: 'Создать',
          ),
          // Admin
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
    );
  }
}