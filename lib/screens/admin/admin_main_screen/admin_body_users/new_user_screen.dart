
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'package:svd_doc/logic/global_const.dart';


class NewUsersAdminScreen extends StatelessWidget{
  final User user;
  const NewUsersAdminScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: NewUsersFontAppBar(),
      ),
      body: NewUserBody(user: user,),
    );
  }
}

class NewUsersFontAppBar extends StatelessWidget {
  final UserDataBase db = UserDataBase();

  NewUsersFontAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                },
                icon: const Icon(Icons.menu_outlined),
                color: mySet.white,
              )),

          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/app_bar/new_users_admin.png',
                width: width,
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: const Text('Панель\nадминистратора',
                style: TextStyle(
                    color: mySet.white,
                    fontSize: 26,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
          ),
          Positioned(
              left: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                  print(112);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: mySet.white,
              )),
        ],
      ),
    );
  }
}

class NewUserBody extends StatefulWidget{
  final User user;
  const NewUserBody({super.key, required this.user});

  @override
  State<NewUserBody> createState() => _NewUserBodyState();
}

class _NewUserBodyState extends State<NewUserBody> {

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/big_icons/new_user_avatar.png',
            height: 70,
          ),
          Text("${widget.user.surname} ${widget.user.name}",
              style: const TextStyle(
                  color: mySet.main,
                  fontSize: 20,
                  fontFamily: "Italic",
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 3,),
          Text("+${widget.user.phone}",
              style: const TextStyle(
                  color: mySet.second,
                  fontSize: 14,
                  fontFamily: "Italic",
                  fontWeight: FontWeight.w400)),
        ]

      ),
    );
  }
}