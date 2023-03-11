
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/screens/active_read_screen/active_msg_read_screen.dart';


class LineAdminBody extends StatefulWidget {
  const LineAdminBody({super.key});
  @override
  State<LineAdminBody> createState() => _LineAdminBodyState();
}

class _LineAdminBodyState extends State<LineAdminBody> {
  List<ActiveMsg> activeList = [];
  ApiSVD api = ApiSVD();

  @override
  void initState() {
    updateActive();
    super.initState();
  }

  void updateActive() async {
    activeList = await api.getActive();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (activeList.isEmpty) {
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
              const Text('У вас на рассмотрении\nнет новых документов,',
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
    } else {
      return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16,),
            const Text('Вот документы, ожидающие',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
            const Text('вашего согласования',
                style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
            const SizedBox(height: 18,),
            for (ActiveMsg one in activeList) ActiveMsgCard(
              onTap: () async {
                BillDocument bill = await api.getBill(billId: one.docId);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      ActiveBillScreen(activeMsg: one, bill: bill,),),
                );
              },
              activeMsg: one,
            ),
          ],
        ),
      );
    }
  }
}

class ActiveMsgCard extends StatefulWidget{
  final GestureTapCallback onTap;
  final ActiveMsg activeMsg;
  const ActiveMsgCard({super.key, required this.onTap, required this.activeMsg});

  @override
  State<ActiveMsgCard> createState() => _ActiveMsgCardState();
}

class _ActiveMsgCardState extends State<ActiveMsgCard> {
  bool press = false;
  @override
  Widget build(BuildContext context) {
    DateTime create = DateTime.parse(widget.activeMsg.createDate);
    var dur = DateTime.now().difference(create);
    int hours = dur.inMinutes ~/ 60;
    int minutes = dur.inMinutes % 60;

    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTapDown: (tap) {
          press = true;
          setState(() { });

      },
      onTapUp: (tap) {
          press = false;
          setState(() {});

      },
      onTapCancel: () {
          press = false;
          setState(() {});
      },
      onTap: widget.onTap,
      child: Container(

        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 6, right: 6),
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(
                color: mySet.input,
                blurRadius: 5,
                offset: Offset(-3, 3)
            )],
          border: Border.all(color: mySet.input, width: 1),
          color: press ? mySet.shadow : mySet.white,
        ),
        alignment: Alignment.centerLeft,
        height: 62,
        width: width-40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width-140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.activeMsg.title,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
                  Text(widget.activeMsg.description,
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            Column(
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
            )
          ],
        ),
      ),
    );
  }
}