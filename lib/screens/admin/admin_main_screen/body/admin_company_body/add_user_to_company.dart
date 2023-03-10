
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/admin/main_admin_inherit.dart';


class AddUserToCompany extends StatefulWidget{
  final Company company;
  const AddUserToCompany({super.key, required this.company});

  @override
  State<AddUserToCompany> createState() => _AddUserToCompanyState();
}

class _AddUserToCompanyState extends State<AddUserToCompany> {
  List<User> freeUsersList = [];
  List<String> companyTypeItems = [];
  List<DropdownMenuItem<int>> dropUsersItems = [];
  List<DropdownMenuItem<int>> dropProfessionItems = [];
  int? dropUserValue;
  int? dropProfessionValue;
  User? pickUser;
  List<Profession> pickListPro = ListProfession.professionSvd;
  Profession pickProfession = ListProfession.professionSvd.first;
  final ApiSVD api = ApiSVD();

  @override
  void initState() {
    updateDropUsersItems();
    super.initState();
  }

  void updateDropUsersItems() async {
    freeUsersList = await api.usersInCompany(widget.company.companyId);
    dropUsersItems = [];
    int i = 0;
    for (User user in freeUsersList) {
      dropUsersItems.add(DropdownMenuItem(
        value: i,
        child: Text("${user.surname} ${user.name}",
                style: const TextStyle(
                    color: mySet.main,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),

      ));
      i += 1;
    }
    setState(() {});
  }

  void updateDropProfession() {
    int companyType = widget.company.companyId;
    if (companyType == 2) {
      pickListPro = ListProfession.professionRead;
    }
    if (companyType == 3) {
      pickListPro = ListProfession.professionNotification;
    }

    dropProfessionItems = [];
    int i = 0;
    for (Profession item in pickListPro) {
      dropProfessionItems.add(DropdownMenuItem(
        value: i,
        child: Text(item.name,
            style: const TextStyle(
                color: mySet.second,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
      ));
      i += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<User> usersCompanyLine = MainAdminInherit.of(context)?.usersCompanyLine ?? [];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: mySet.background,
      child: Stack(
        children: [
          Positioned(
          bottom: 0,
          child: Image.asset('assets/background/add_user_to_company.png', width: width,)
      ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                  children: [
                    const SizedBox(height: 18,),
                    SizedBox(
                      width: width,
                      child: const Text('?????????????? ????????????????',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: mySet.main,
                              fontSize: 14,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 6,),
                    Container(
                      decoration: const BoxDecoration(
                          color: mySet.white,
                          boxShadow: [BoxShadow(
                              color: mySet.unSelect,
                              blurRadius: 5,
                              offset: Offset(-3, 3)
                          )]
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: width - 40,
                      child: DropdownButton<int>(
                        items: dropUsersItems,
                        value: dropUserValue,
                        hint: const Text('?????????????????? ????????????????????????',
                          style: TextStyle(
                            color: mySet.second,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400),),
                        style: const TextStyle(
                            color: mySet.main,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400),
                        underline: const SizedBox(),
                        isExpanded: true,
                        menuMaxHeight: 300,
                        onChanged: (value) {
                          dropUserValue = value;
                          if (value != null) {
                            pickUser = freeUsersList[value];
                            updateDropProfession();
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    UniversalBtn(
                      width: width,
                      enable: pickUser != null ? true : false,
                      text: '???????????????? ????????????????????',
                      textStyle: const TextStyle(
                          color: mySet.white,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                      onTap: () {
                        usersCompanyLine.add(pickUser!);
                        String usersLine = '';
                        for (User user in usersCompanyLine) {
                          usersLine = "$usersLine${user.userId},";
                        }
                        if (usersCompanyLine.length == 1) {
                          api.createCompanyLineUsers(widget.company.companyId, usersLine.substring(0, usersLine.length-1));
                        } else {
                          api.updateCompanyLineUsers(widget.company.companyId, usersLine.substring(0, usersLine.length-1));
                        }

                        MainAdminInherit.of(context)?.insertUsersCompanyLine(usersCompanyLine);
                        Timer(const Duration(milliseconds: 100), () {
                          MainAdminInherit.of(context)?.setNewCompanyWidgetToBody(widget.company);
                        });

                      },
                    ),
                  ],
                ),


          ),
        ],
      ),
    );
  }
}