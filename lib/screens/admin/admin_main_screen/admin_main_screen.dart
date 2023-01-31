
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

import '../../../logic/data_base.dart';

class AdminMainScreen extends StatefulWidget{
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  UserDataBase db = UserDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          backgroundColor: mySet.main,
          flexibleSpace: Container(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/app_bar/admin_main.png')),
          actions: [
            IconButton(onPressed: (){
              db.deleteUser();
              Navigator.of(context).popAndPushNamed('/login');
            },
              icon: const Icon(Icons.menu_outlined), color: mySet.background,)
          ],
          centerTitle: true,
          title: const Text(
            'Панель объектов',
            style: TextStyle(
                color: mySet.input,
                fontSize: 26,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}