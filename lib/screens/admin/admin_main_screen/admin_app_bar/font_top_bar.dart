import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import '../../main_admin_inherit.dart';


class FontTopBar extends StatefulWidget {
  const FontTopBar({
    super.key,
    this.backIcon = false,
    this.backOnPress,
  });
  final bool backIcon;
  final VoidCallback? backOnPress;

  @override
  State<FontTopBar> createState() => _FontTopBarState();
}

class _FontTopBarState extends State<FontTopBar> {
  UserDataBase db = UserDataBase();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = MainAdminInherit.of(context);
    model?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackList = [
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
            MainAdminInherit.of(context)?.assetsImageFont ?? 'assets/app_bar/admin_main.png',
            height: 140,
          )
      ),
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
                fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.center,
          )
      ),
    ];

    if (MainAdminInherit.of(context)?.backIcon ?? false) {
      stackList.insert(3, Positioned(
        left: 20,
        top: 50,
        child: IconButton(
          onPressed: MainAdminInherit.of(context)?.backOnPressed ?? () {},
          icon: const Icon(Icons.arrow_back_ios),
          color: mySet.white,
        )),);
    }

    return Container(
      color: mySet.main,
      height: 160,
      child: Stack(
        children: stackList,
      ),
    );
  }
}
