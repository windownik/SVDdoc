
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'app_bar_main_admin_inherit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminMainBottomNavigationBar extends StatefulWidget {
  const AdminMainBottomNavigationBar({super.key});

  @override
  State<AdminMainBottomNavigationBar> createState() =>
      _AdminMainBottomNavigationBarState();
}

class _AdminMainBottomNavigationBarState
    extends State<AdminMainBottomNavigationBar> {
  int index = 0;
  bool actActive = true,
      actArchive = false,
      actNewDoc = false,
      actAdmin = false;

  void pickItem(int newIndex) {
    index = newIndex;
    AppBarMainAdminInherit.of(context)?.pickItem(newIndex);
    actActive = index == 0 ? true : false;
    actArchive = index == 1 ? true : false;
    actNewDoc = index == 2 ? true : false;
    actAdmin = index == 3 ? true : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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
              color: actActive ? mySet.white : mySet.second,
            ),
            label: 'Активные',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_archive.svg',
              semanticsLabel: 'Acme Logo',
              color: actArchive ? mySet.white : mySet.second,
            ),
            label: 'Архив',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_new_doc.svg',
              semanticsLabel: 'Acme Logo',
              color: actNewDoc ? mySet.white : mySet.second,
            ),
            label: 'Создать',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bottom_bar_admin.svg',
              semanticsLabel: 'Acme Logo',
              color: actAdmin ? mySet.white : mySet.second,
            ),
            label: 'Админ',
          ),
        ],
      ),
    );
  }
}
