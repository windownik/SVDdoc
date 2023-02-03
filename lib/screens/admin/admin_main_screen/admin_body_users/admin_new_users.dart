import 'package:flutter/material.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/global_const.dart';

import 'new_user_card.dart';

//-----------------
//Админ тело основоного экрана


class AdminUsersMainInfo extends StatefulWidget {
  const AdminUsersMainInfo({super.key});
  @override
  State<AdminUsersMainInfo> createState() => _AdminMainInfoState();
}

class _AdminMainInfoState extends State<AdminUsersMainInfo> {
  final ApiSVD api = ApiSVD();
  List newUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiNewUsers();
  }

  void getApiNewUsers() async {
    newUsers = await api.getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (newUsers.isEmpty == false) {
      return NewUserCardInherit(
        model: NewUserCardModel(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Center(
                child: Text('У вас ${newUsers.length} новых пользователей',
                    style: const TextStyle(
                        color: mySet.main,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w300)),
              ),
              for (var i in newUsers) (NewUserCard(user: i,))
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('Отличная работа!',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 13,
            ),
            const Text('Все документы согласованы',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/big_icons/active_empty.png',
              height: 200,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
