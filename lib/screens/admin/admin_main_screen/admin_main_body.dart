import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';

import '../../../logic/api.dart';
import '../../../logic/data_base.dart';
import 'app_bar_main_admin_inherit.dart';

class LineAdminMainInfo extends StatefulWidget {
  const LineAdminMainInfo({super.key});
  @override
  State<LineAdminMainInfo> createState() => _LineAdminMainInfoState();
}

class _LineAdminMainInfoState extends State<LineAdminMainInfo> {
  @override
  Widget build(BuildContext context) {
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
      return Padding(
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
            for (var i in newUsers)
              (NewUserCard(
                user: i,
              ))
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

class NewUserCard extends StatelessWidget {
  final User user;
  const NewUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(
        top: 18,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: mySet.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${user.name} ${user.surname}",
                  style: const TextStyle(
                      color: mySet.main,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400)),
              Text("+${user.phone}",
                  style: const TextStyle(
                      color: mySet.second,
                      fontSize: 14,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/clock_gray.svg',
                  semanticsLabel: 'Acme Logo'),
              const Text("2ч 15 мин",
                  style: TextStyle(
                      color: mySet.second,
                      fontSize: 14,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400))
            ],
          ),
        ],
      ),
    );
  }
}
