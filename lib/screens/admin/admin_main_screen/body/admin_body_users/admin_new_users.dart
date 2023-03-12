import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/pop_ups/func_chow_pop_ups.dart';

import 'admin_all_users.dart';
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
    super.initState();
    getApiNewUsers();
  }

  void getApiNewUsers() async {
    try {
      newUsers = await api.getUsers();
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (newUsers.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    const SizedBox(height: 10,),
                    Center(
                      child: Text('У вас ${newUsers.length} новых пользователей',
                          style: const TextStyle(
                              color: mySet.main,
                              fontSize: 16,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w300)),
                    ),
                    for (var i in newUsers) (NewUserCard(user: i,)),

                  ],
                ),
              ),
              const SizedBox(height: 20,),
              UniversalBtn(
                text: 'Все пользователи',
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        const AdminAllUsersInfo(),),
                  );
                },
                textStyle: const TextStyle(color: mySet.white),
                width: double.infinity,
              ),
              const SizedBox(height: 27,),

            ],
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
            const Text('У вас нет новых пользователей.',
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
            ),
            const SizedBox(height: 20,),
            UniversalBtn(
              width: width-40,
              textStyle: const TextStyle(
                color: mySet.white,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
              text: 'Все пользователи', onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                const AdminAllUsersInfo(),),
              );
            },),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
