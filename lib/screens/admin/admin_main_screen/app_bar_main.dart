import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'app_bar_main_admin_inherit.dart';

class AppBarMainAdmin extends StatelessWidget{
  const AppBarMainAdmin({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: const [
        FontAppBar(),
      ],






      // AppBar(
      //   backgroundColor: mySet.main,
      //   flexibleSpace: Container(
      //       alignment: Alignment.bottomLeft,
      //       child: Image.asset('assets/app_bar/admin_main.png')),
      //   actions: [
      //     IconButton(onPressed: (){
      //       db.deleteUser();
      //       Navigator.of(context).popAndPushNamed('/login');
      //     },
      //       icon: const Icon(Icons.menu_outlined), color: mySet.background,)
      //   ],
      //   centerTitle: true,
      //   title: const Text(
      //     'Панель объектов',
      //     style: TextStyle(
      //         color: mySet.input,
      //         fontSize: 26,
      //         fontFamily: "Italic",
      //         fontWeight: FontWeight.w300),
      //   ),
      // ),
    );
  }
}

class FontAppBar extends StatefulWidget{
  const FontAppBar({super.key});

  @override
  State<FontAppBar> createState() => _FontAppBarState();
}

class _FontAppBarState extends State<FontAppBar> {

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
      child: Stack(children: [

          Positioned(
            bottom: 0, left: 0,
              child: Image.asset('assets/app_bar/admin_main.png', height: 140,)
          ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          child: Text(AppBarMainAdminInherit.of(context)?.mainTitle ?? 'Панель\nадминистратора',
          style: const TextStyle(fontSize: 26, color: mySet.white),
          maxLines: 2,
            textAlign: TextAlign.center,
          )
          ),
      ],),
    );
  }
}