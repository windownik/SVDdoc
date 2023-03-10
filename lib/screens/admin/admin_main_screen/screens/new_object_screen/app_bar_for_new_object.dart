
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class AppBarNewObject extends StatelessWidget{
  final UserDataBase db = UserDataBase();
  AppBarNewObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: mySet.main,),
        Positioned(
            right: 20,
            top: 50,
            child: IconButton(
              onPressed: () {
                db.deleteUser();
                Navigator.of(context).popAndPushNamed('/login');
              },
              icon: const Icon(Icons.menu_outlined),
              color: mySet.main,
            )),
        Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/app_bar/admin_main.png',
              height: 140,
            )
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Новый объект',
              style: TextStyle(
                  color: mySet.white,
                  fontSize: 26,
                  fontFamily: "Italic",
                  fontWeight: FontWeight.w400),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
        ),
        Positioned(
            left: 20,
            top: 50,
            child: IconButton(
              onPressed: () {Navigator.of(context).pop();},
              icon: const Icon(Icons.arrow_back_ios),
              color: mySet.white,
            )),
      ],
    );
  }
}