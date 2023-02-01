import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'app_bar_main_admin_inherit.dart';

class AppBarMainAdmin extends StatelessWidget {
  const AppBarMainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FontAppBar(),
        SmallAdminBar(showTopBar: true,)
      ],
    );
  }
}

class SmallAdminBar extends StatelessWidget{
  const SmallAdminBar({super.key, required this.showTopBar});

  final bool showTopBar;

  @override
  Widget build(BuildContext context) {
    if (!showTopBar) {
      return Container(width: 1,);
    }
    return Container(
      height: 70,
      color: mySet.shadow,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CompanyBtn(),
          Container(height: 30, width: 1, color: mySet.unSelect,),
          const UsersBtn(),
          Container(height: 30, width: 1, color: mySet.unSelect,),
          const ObjectBtn(),
        ]
      ),
    );
  }
}

class CompanyBtn extends StatefulWidget{
  const CompanyBtn({super.key});

  @override
  State<CompanyBtn> createState() => _CompanyBtnState();
}

class _CompanyBtnState extends State<CompanyBtn> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  bool pres = false;
  @override
  Widget build(BuildContext context) {
    pres = AppBarMainAdminInherit.of(context)?.companyActive ?? false;
    return GestureDetector(
      onTap: () {
        AppBarMainAdminInherit.of(context)?.activateCompany();
      },
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

class UsersBtn extends StatefulWidget{
  const UsersBtn({super.key});

  @override
  State<UsersBtn> createState() => _UsersBtnState();
}

class _UsersBtnState extends State<UsersBtn> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  bool pres = false;
  @override
  Widget build(BuildContext context) {
    pres = AppBarMainAdminInherit.of(context)?.usersActive ?? false;
    return GestureDetector(
      onTap: () {
        AppBarMainAdminInherit.of(context)?.activateUsers();
      },
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

class ObjectBtn extends StatefulWidget{
  const ObjectBtn({super.key});

  @override
  State<ObjectBtn> createState() => _ObjectBtnState();
}

class _ObjectBtnState extends State<ObjectBtn> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  bool pres = false;
  @override
  Widget build(BuildContext context) {
    pres = AppBarMainAdminInherit.of(context)?.objectActive ?? false;
    return GestureDetector(
      onTap: () {
        AppBarMainAdminInherit.of(context)?.activateObject();
      },
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final model = AppBarMainAdminInherit.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

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
