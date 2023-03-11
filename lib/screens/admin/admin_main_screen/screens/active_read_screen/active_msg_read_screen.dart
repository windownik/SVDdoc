
import 'package:flutter/material.dart';

import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_upload_photo/spending_const_big_card.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_upload_photo/title_card.dart';

class ActiveBillScreen extends StatefulWidget{
  final ActiveMsg activeMsg;
  final BillDocument bill;
  const ActiveBillScreen({super.key, required this.activeMsg, required this.bill});

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
          width: width,
          child: Column(
            children: [
              const SizedBox(height: 16,),
              const Text('Счет на оплату',
                  style: TextStyle(
                      color: mySet.main,
                      fontSize: 22,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w300)),
              Text('№ ${widget.activeMsg.docId}',
                  style: const TextStyle(
                      color: mySet.second,
                      fontSize: 20,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w300)),
              const SizedBox(height: 16,),
              TopBillCard(bill: widget.bill,),
              const SizedBox(height: 18,),
              BottomBillCard(bill: widget.bill,),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBillCard extends StatelessWidget{
  const TopBillCard({super.key, required this.bill});
  final BillDocument bill;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      width: width-40,
      decoration: const BoxDecoration(
        color: mySet.white,
        boxShadow: [BoxShadow(
            color: mySet.input,
            blurRadius: 5,
            offset: Offset(-3, 3)
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleCard(text: 'Контрагент',),
          const SizedBox(height: 12,),
          Text(
            bill.contRAgent.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5,),
          Text(
            bill.pickObject.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 12,),
          Container(height: 1, width: width-40, color: mySet.input,),
          const TitleCard(text: 'Статьи затрат',),
          for (SpendingConst one in bill.spendingConstList)
            SpendingConstBigCard(spendingConst: one,),
          const SizedBox(height: 12,),
          Container(height: 1, width: width-40, color: mySet.input,),
          const TitleCard(text: 'Инвестор',),
          const SizedBox(height: 12,),
          Text(
            bill.investor.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 12,),
          Container(height: 1, width: width-40, color: mySet.input,),
          const TitleCard(text: 'Создал документ',),
          const SizedBox(height: 12,),
          Text(
            bill.creator.profession,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5,),
          Text(
            "${bill.creator.surname} ${bill.creator.name}",
            style: const TextStyle(
                color: mySet.second,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 12,),
          Text(
            bill.comment,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class BottomBillCard extends StatelessWidget{
  const BottomBillCard({super.key, required this.bill});
  final BillDocument bill;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      width: width-40,
      decoration: const BoxDecoration(
        color: mySet.background,
        boxShadow: [BoxShadow(
            color: mySet.input,
            blurRadius: 5,
            offset: Offset(-3, 3)
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (User user in bill.usersLine) Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width-100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14,),
                        Text(
                          "${user.surname} ${user.name}",
                          style: const TextStyle(
                              color: mySet.main,
                              fontSize: 14,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          user.profession,
                          style: const TextStyle(
                              color: mySet.main,
                              fontSize: 16,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  CheckStatusBox(check: user.userId % 2 == 0 ? true : false,),
                ],
              ),
              const SizedBox(height: 12,),
              Container(height: 1, width: width-40, color: mySet.input,),
            ],
          )
        ],
      ),
    );
  }
}

class CheckStatusBox extends StatelessWidget{
  const CheckStatusBox({super.key, required this.check});
  final bool check;

  @override
  Widget build(BuildContext context) {
    if (check) {
      return Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: mySet.background,
          border: Border.all(width: 1, color: mySet.input),
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [BoxShadow(
              color: mySet.input,
              blurRadius: 5,
              offset: Offset(-2, 2)
          )],
        ),
        child: const Icon(Icons.check_outlined, color: mySet.liteGreen,),
      );
    }
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: mySet.background,
        border: Border.all(width: 1, color: mySet.input),
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [BoxShadow(
            color: mySet.input,
            blurRadius: 5,
            offset: Offset(-2, 2)
        )],
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.clear_outlined, color: mySet.softRed,),
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