import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import '../main_admin_inherit.dart';




class FontTopBar extends StatefulWidget {
  const FontTopBar({
    super.key,
    this.imageAsset = 'assets/app_bar/admin_main.png'
  });
  final String imageAsset;

  @override
  State<FontTopBar> createState() => _FontTopBarState();
}

class _FontTopBarState extends State<FontTopBar> {
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
                MainAdminInherit.of(context)?.mainTitle ??
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
