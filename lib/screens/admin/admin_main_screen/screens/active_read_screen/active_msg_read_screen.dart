
import 'package:flutter/material.dart';

import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/logic/data_base.dart';

class ActiveBillScreen extends StatefulWidget{
  final ActiveMsg activeBill;
  const ActiveBillScreen({super.key, required this.activeBill});

  @override
  State<ActiveBillScreen> createState() => _CreateNewObjectScreenState();
}

class _CreateNewObjectScreenState extends State<ActiveBillScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // bool emptyName = true;

    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBarBillActive(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: mySet.background,
          width: width-40,
          child: Column(
            children: [
              const SizedBox(height: 16,),
              const Text('Счет на оплату',
                  style: TextStyle(
                      color: mySet.main,
                      fontSize: 22,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w300)),
              Text('№ ${widget.activeBill.docId}',
                  style: const TextStyle(
                      color: mySet.second,
                      fontSize: 20,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w300)),
              const SizedBox(height: 16,),
              Container(
                width: width-40,
                decoration: BoxDecoration(
                  color: mySet.white,
                ),
                child: Column(

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarBillActive extends StatelessWidget{
  final UserDataBase db = UserDataBase();
  AppBarBillActive({super.key});

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
              'Счет\nна рассмотрении',
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