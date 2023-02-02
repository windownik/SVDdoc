import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'app_bar_main_admin_inherit.dart';

class SmallAdminBar extends StatefulWidget{
  const SmallAdminBar({super.key});

  @override
  State<SmallAdminBar> createState() => _SmallAdminBarState();
}

class _SmallAdminBarState extends State<SmallAdminBar> {
  int pickBtn = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: mySet.shadow,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CompanyBtn(pres: pickBtn == 0 ? true : false,
            onTap: () {
            pickBtn = 0;
            setState(() { });
            },),
          Container(height: 30, width: 1, color: mySet.unSelect,),
          UsersBtn(pres: pickBtn == 1 ? true : false,
            onTap: () {
              pickBtn = 1;
              setState(() { });
            },),
          Container(height: 30, width: 1, color: mySet.unSelect,),
          ObjectBtn(pres: pickBtn == 2 ? true : false,
            onTap: () {
            pickBtn = 2;
            setState(() { });
            },),
        ]
      ),
    );
  }
}

class CompanyBtn extends StatelessWidget{
  const CompanyBtn({super.key, required this.pres, required this.onTap});

  final bool pres;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        color: Colors.transparent,
        child: Text('Редактор\nюр. лиц.',
          style: TextStyle(
              color: pres ? mySet.main : mySet.unSelect,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class UsersBtn extends StatelessWidget{
  const UsersBtn({super.key, required this.pres, required this.onTap});

  final bool pres;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        color: Colors.transparent,
        child: Text('Пользователи',
          style: TextStyle(
              color: pres ? mySet.main : mySet.unSelect,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class ObjectBtn extends StatelessWidget{
  const ObjectBtn({super.key, required this.pres, required this.onTap});
  final bool pres;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        color: Colors.transparent,
        child: Text('Редактор\nобъектов',
          style: TextStyle(
              color: pres ? mySet.main : mySet.unSelect,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
          maxLines: 2,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}

class FontAppBar extends StatefulWidget {
  const FontAppBar({super.key});

  @override
  State<FontAppBar> createState() => _FontAppBarState();
}

class _FontAppBarState extends State<FontAppBar> {
  UserDataBase db = UserDataBase();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mySet.main,
      height: 160,
      child: Stack(
        children: [
          Positioned(
              right: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                  db.deleteUser();
                  Navigator.of(context).popAndPushNamed('/login');
                },
                icon: const Icon(Icons.menu_outlined),
                color: mySet.white,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/app_bar/admin_main.png',
                height: 140,
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                AppBarMainAdminInherit.of(context)?.mainTitle ??
                    'Панель\nадминистратора',
                style: const TextStyle(
                    color: mySet.white,
                    fontSize: 26,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
          ),
        ],
      ),
    );
  }
}
