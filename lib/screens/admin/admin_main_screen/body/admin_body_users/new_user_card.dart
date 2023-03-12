

import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/screens/admin/main_admin_inherit.dart';

import 'AdminUserInfoChange.dart';



class NewUserCard extends StatefulWidget {
  final User user;
  const NewUserCard({super.key, required this.user});

  @override
  State<NewUserCard> createState() => _NewUserCardState();
}

class _NewUserCardState extends State<NewUserCard> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    DateTime create = DateTime.parse(widget.user.createDate);
    var dur = DateTime.now().difference(create);
    int hours = dur.inMinutes ~/ 60;
    int minutes = dur.inMinutes % 60;

    return GestureDetector(
      onTapDown: (a) {
        pres = true;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapUp: (a){
        pres = false;

        setState(() { });
      },
      onTap: () {
        MainAdminInherit.of(context)?.setNewUserCardWidgetToBody(widget.user);
      },
      child: Container(
        height: 62,
        margin: const EdgeInsets.only(
          top: 18,
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        color: pres ? mySet.shadow : mySet.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${widget.user.name} ${widget.user.surname}",
                    style: const TextStyle(
                        color: mySet.main,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                Text("+${widget.user.phone}",
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
                Text("$hoursч $minutesмин",
                    style: const TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AllUserCard extends StatefulWidget {
  final User user;
  const AllUserCard({super.key, required this.user});

  @override
  State<AllUserCard> createState() => _AllUserCardState();
}

class _AllUserCardState extends State<AllUserCard> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    // DateTime create = DateTime.parse(widget.user.createDate);
    // var dur = DateTime.now().difference(create);
    // int hours = dur.inMinutes ~/ 60;
    // int minutes = dur.inMinutes % 60;

    return GestureDetector(
      onTapDown: (a) {
        pres = true;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapUp: (a){
        pres = false;

        setState(() { });
      },
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              ChangeUsersInfo(user: widget.user,),),
        );
      },
      child: Container(
        height: 62,
        margin: const EdgeInsets.only(
          top: 18,
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        color: pres ? mySet.shadow : mySet.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${widget.user.name} ${widget.user.surname}",
                    style: const TextStyle(
                        color: mySet.main,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                Text("+${widget.user.phone}",
                    style: const TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.user.profession,
                    style: const TextStyle(
                        color: mySet.main,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                Text(widget.user.companyName,
                    style: const TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}