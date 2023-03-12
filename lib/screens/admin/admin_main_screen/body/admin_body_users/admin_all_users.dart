import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/auth_registration/pop_ups/func_chow_pop_ups.dart';

import 'new_user_card.dart';

//-----------------
//Админ тело основоного экрана


class AdminAllUsersInfo extends StatefulWidget {
  const AdminAllUsersInfo({super.key});
  @override
  State<AdminAllUsersInfo> createState() => _AdminAllUsersInfoState();
}

class _AdminAllUsersInfoState extends State<AdminAllUsersInfo> {
  final ApiSVD api = ApiSVD();
  List newUsers = [];

  @override
  void initState() {
    super.initState();
    getApiNewUsers();
  }

  void getApiNewUsers() async {
    try {
      newUsers = await api.getAllUsers();
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: mySet.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBarAllUsers(),
        ),
        body: newUsers.isNotEmpty ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    const SizedBox(height: 10,),
                    Center(
                      child: Text('Количество всех пользователей ${newUsers.length}.',
                          style: const TextStyle(
                              color: mySet.main,
                              fontSize: 16,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w300)),
                    ),
                    for (var i in newUsers) (AllUserCard(user: i,)),

                  ],
                ),
              ),

            ],
          ),
        ) : SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text('Здесь пусто!',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 18,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 13,
                ),
                const Text('У вас нет пользователей!',
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
                  text: 'Назад',
                  width: width-40,
                  textStyle: const TextStyle(color: mySet.white),
                  onTap: () {
                    Navigator.pop(context);
                  },),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        )
    );
  }
}


class AppBarAllUsers extends StatelessWidget{
  final UserDataBase db = UserDataBase();
  AppBarAllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              'assets/app_bar/new_doc.png',
              width: width,
            )
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Все пользователи',
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