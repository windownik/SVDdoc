import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/custome_icon_button.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/global_pop_ups/success_create_bill.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class NewBillUsersLineScreen extends StatefulWidget {
  const NewBillUsersLineScreen({super.key, required this.billDocument});
  final BillDocument billDocument;

  @override
  State<NewBillUsersLineScreen> createState() => _NewBillUsersLineScreenState();
}

class _NewBillUsersLineScreenState extends State<NewBillUsersLineScreen> {
  bool textHintEmpty = true;
  UserDataBase  db = UserDataBase();
  ApiSVD api = ApiSVD();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                color: mySet.main,
                child: Image.asset(
                  'assets/app_bar/new_doc.png',
                  width: width,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 55),
                alignment: Alignment.center,
                child: const Text('Новый счёт',
                    style: TextStyle(
                        color: mySet.white,
                        fontSize: 26,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w300)),
              )
            ],
          )),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          height: height-160,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/background/new_bill.png',
                    width: width,
                  )),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [
                  const SizedBox(height: 18,),
                  const Text(
                    'Очередность в листе согласований',
                    style: TextStyle(
                        color: mySet.main,
                        fontSize: 18,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w300),
                  ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: widget.billDocument.usersLine.length*62,
                  child: ReorderableListView(
                    children: [
                      for (var user in widget.billDocument.usersLine) UserLineCard(
                          key: ValueKey(user.userId),
                          user: user,),
                    ],
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final User user = widget.billDocument.usersLine.removeAt(oldIndex);
                        widget.billDocument.usersLine.insert(newIndex, user);

                      });
                    },
                  ),
                ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) => mySet.input),
                    ),
                    onPressed: () async {},
                    child: const Text(
                      'Добавить специалиста',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: UniversalBtn(
            width: width - 40,
            text: 'Отправить документ',
            textStyle: const TextStyle(
                color: mySet.white,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
            onTap: () async {

              String? status = await showDialog(
                  context: (context),
                  builder: (BuildContext context) {
                    return CreateNewBill(billDocument: widget.billDocument,);
                  });
              if (status != null) {
                Navigator.of(context).pushNamedAndRemoveUntil('/admin_start', (route) => false);
              }
            }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}


class UserLineCard extends StatelessWidget{
  const UserLineCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      // alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 6, top: 8, bottom: 8, right: 6),
      margin: const EdgeInsets.only(bottom: 10),
      height: 52,
      width: width-40,
      decoration: const BoxDecoration(
        color: mySet.white,
        boxShadow: [BoxShadow(
            color: mySet.unSelect,
            blurRadius: 5,
            offset: Offset(-3, 3)
        )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width-40-65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.profession,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${user.companyName}  ",
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Text(
                '${user.surname} ${user.name}',
                style: const TextStyle(
                    color: mySet.second,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            color: mySet.input,
            width: 1,
            height: 50,
          ),
          MyIconButton(
            icon: const Icon(Icons.delete_forever, color: mySet.softRed),
            onTap: () {  },
          ),
        ],
      ),
    );
  }
}
