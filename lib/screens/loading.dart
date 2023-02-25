
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

import '../logic/api.dart';
import 'admin/admin_main_screen.dart';
import 'auth_registration/login_start/login_main.dart';

class Loading extends StatefulWidget{
  const Loading({super.key});

  @override
  State<StatefulWidget> createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  User? user;
  ApiSVD api = ApiSVD();
  UserDataBase db = UserDataBase();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    try {
      user = await api.userGet();
    } catch (e){
      if (e.toString() == 'Exception: 401') {
        user = db.getUser();
      } else {
        print(e);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const LoadingScreen();
    }
    else if (user?.userId == 0) {
      return const LoginScreen();
    } else if (user?.status == 'admin') {
      return const AdminMainScreen();
    } else if (user?.status == 'simple') {
      return const LoginScreen();
    } else if (user?.status == 'creator') {
      return const LoginScreen();
    }
    return const LoadingScreen();
  }
}


class LoadingScreen extends StatelessWidget{
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
        color: mySet.background,
        child: Stack(children: [
          const Positioned(
            right: 0,
              top: 56,
              child: DecorRight()
          ),
          Center(child:
          SizedBox(height: 250, width: 200, child: Column(
            children: [
              Image.asset("assets/big_icons/main_logo.png"),
              LoadingAnimationWidget.prograssiveDots(
                color: mySet.input,
                size: 50,
              ),
            ],
          ))
            ),
          const Positioned(
              left: 0,
              bottom: 0,
              child: DecorLeft()
          ),
        ],)
      );
  }
}

class DecorRight extends StatelessWidget{
  const DecorRight({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 340,
      child: Stack(
        children: [
          Positioned(
            right: -1, top: 28,
            child: Container(height: 307, width: 51,
              color: mySet.input,),
          ),
          Positioned(
            right: -1, top: 0,
            child: Container(height: 307, width: 20,
              decoration: BoxDecoration(
                border: Border.all(color: mySet.main)
              ),),
          ),
          Positioned(
            right: -1, top: 17,
            child: Container(height: 307, width: 36,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),

        ],
      ),
    );
  }
}

class DecorLeft extends StatelessWidget{
  const DecorLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 170,
      child: Stack(
        children: [
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 140, width: 81,
              color: mySet.input,),
          ),
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 151, width: 96,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 168, width: 112,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),

        ],
      ),
    );
  }
}