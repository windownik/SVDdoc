import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/admin/main_admin_inherit.dart';
import 'package:svd_doc/screens/auth_registration/pop_ups/func_chow_pop_ups.dart';

import '../user_in_company_card.dart';


class NewCompanyAdminBody extends StatefulWidget {
  const NewCompanyAdminBody({super.key, this.company});
  final Company? company;
  @override
  State<NewCompanyAdminBody> createState() => _NewCompanyAdminBodyState();
}

class _NewCompanyAdminBodyState extends State<NewCompanyAdminBody> {
  final _newCompanyName = TextEditingController();
  final ApiSVD api = ApiSVD();
  // List<User> allUsers = [];
  List<DropdownMenuItem<int>> dropItems = [];
  final List<String> typesCompany = ['Технический заказчик', 'Инвестор', 'Контрагент'];
  bool enable = false;
  bool textEmpty = true;
  int? dropValue;

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _newCompanyName.text = widget.company?.name ?? '';
      // updateDropItems();
      dropValue = (widget.company?.companyTypeId ?? 1) - 1;
      textEmpty = false;
      setState(() { });
    }
  }


  void updateDropItems() async {
    int i = 0;
    dropItems.clear();
    for (String companyType in typesCompany) {
      dropItems.add(DropdownMenuItem(
        value: i,
        child: Text(companyType,
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = MainAdminInherit.of(context);
    model?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // updateAllUsersCompany();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomHeight = 50;
    if (Platform.isAndroid) {
      bottomHeight = 25;
    } else if (Platform.isIOS) {
      bottomHeight = 50;
    }

    return SingleChildScrollView(
      child: Container(
        height: screenHeight*0.8,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18,),
                  const SizedBox(
                    width: double.infinity,
                    child: Text('Название организации',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 4,),
                  TextFieldWithoutTopHint(
                    hintText: 'ОАО ГорСтрой',
                    textEmpty: textEmpty,
                    fieldController: _newCompanyName,
                    onChanged: (text) {
                      if (widget.company == null) {
                        textEmpty = text.isNotEmpty ? false : true;
                        if (text.isNotEmpty) {
                          updateDropItems();
                        } else {
                          dropItems.clear();
                          dropValue = null;
                        }
                      }
                      setState(() { });
                    },
                  ),
                  const SizedBox(height: 18,),
                  const SizedBox(
                    width: double.infinity,
                    child: Text('Тип организации',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: mySet.main,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 6,),
                  Container(
                    padding: const EdgeInsets.only(left: 10),

                    decoration: const BoxDecoration(
                      color: mySet.white,
                      boxShadow: [BoxShadow(
                          color: mySet.input,
                          blurRadius: 5,
                          offset: Offset(-3, 3)
                      )]),
                    child: DropdownButton<int>(
                      items: dropItems,
                      value: dropValue,
                      hint: const Text('Инвестор', ),
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                      underline: const SizedBox(),
                      isExpanded: true,
                      menuMaxHeight: 300,
                      onChanged: (value) {
                        dropValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1, width: screenWidth*0.32, color: mySet.main,),
                      const Text('  Сотрудники  ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: mySet.main,
                              fontSize: 14,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w500)),
                      Container(height: 1, width: screenWidth*0.32, color: mySet.main,),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  ListUsersCards(
                    allUsers: MainAdminInherit.of(context)?.allUsersCompany ?? [],
                    company: widget.company,
                  ),
                  widget.company != null ? TextButton(
                    onPressed: () {
                      print('Add user to company');
                      MainAdminInherit.of(context)?.setAddNewUserToCompanyWidgetToBody(widget.company!);
                    },
                    child: const Text('Добавить сотрудника',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: mySet.main,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400)),
                  ) :
                  const Text('Что бы добавить сотрудника\nсохраните изменения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
                ],
              )
            ),
            UniversalBtn(
              text: 'Сохранить',
              enable: dropValue != null && _newCompanyName.text.isNotEmpty ? true : false,
              onTap: () async {
                String name = _newCompanyName.text;
                if (widget.company == null) {
                  try {
                    bool status = await api.createCompany(name, (dropValue ?? 0) + 1);
                    if (status) {
                      MainAdminInherit.of(context)?.setAllCompanyListWidgetToBody();
                    }
                  } catch (e) {
                    showPopDefault(e, context);
                  }
                } else {
                  bool status = await api.updateCompany(name, widget.company?.companyId ?? 1);
                  if (status) {
                    MainAdminInherit.of(context)?.setAllCompanyListWidgetToBody();
                  }
                }

              },
              textStyle: const TextStyle(color: mySet.white),
              width: double.infinity,
            ),
            SizedBox(height: bottomHeight,),
          ],
        ),
      ),
    );
  }
}

class ListUsersCards extends StatelessWidget {
  const ListUsersCards({super.key, required this.allUsers, required this.company});
  final List<User> allUsers;
  final Company? company;

  @override
  Widget build(BuildContext context) {

    if (allUsers.isEmpty) {
      return Column(
        children: [
          Image.asset('assets/big_icons/no_user_in_company.png', width: 200,),
            const SizedBox(height: 5,),
            const Text('Список сотрудников пуст',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: mySet.unSelect,
                    fontSize: 16,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 33,),
        ],
      );
    } else {
      return Column(
        children: [
          for (var user in allUsers) (UsersCompanyCard(user: user, company: company!)),
          const SizedBox(height: 20,),
        ],
      );
    }
  }

}