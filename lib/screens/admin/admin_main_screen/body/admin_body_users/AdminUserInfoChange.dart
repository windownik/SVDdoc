import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

import 'admin_all_users.dart';



class ChangeUsersInfo extends StatefulWidget {
  final User user;
  const ChangeUsersInfo({super.key, required this.user});

  @override
  State<ChangeUsersInfo> createState() => _ChangeUsersInfoState();
}

class _ChangeUsersInfoState extends State<ChangeUsersInfo> {
  List<Company> companyList = [];
  List<String> companyTypeItems = ['Auto', '0', '1', '2', '3', '4', '5', '6'];
  List<DropdownMenuItem<int>> dropCompanyItems = [];
  List<DropdownMenuItem<int>> dropProfessionItems = [];
  int? dropCompanyValue;
  int? dropProfessionValue;
  Company? pickCompany;
  bool enableBtn = false;
  List<Profession> pickListPro = ListProfession.professionSvd;
  Profession pickProfession = ListProfession.professionSvd.first;
  final ApiSVD api = ApiSVD();

  @override
  void initState() {
    updateDropItems();

    super.initState();
  }

  void updateDropItems() async {
    companyList = await api.getCompanyList();
    dropCompanyItems = [];
    int i = 0;
    for (Company company in companyList) {
      dropCompanyItems.add(DropdownMenuItem(
        value: i,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(company.name,
                style: const TextStyle(
                    color: mySet.main,
                    fontSize: 16,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
            Text(company.typeName,
                style: const TextStyle(
                    color: mySet.second,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ));
      if (company.companyId == widget.user.companyId) {
        dropCompanyValue = i;
        updateDropProfession(company.companyTypeId, widget.user.profession);
      }
      i += 1;
    }
    setState(() {});
  }

  void updateDropProfession(int companyType, [String? first]) {

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
      if (first != null) {
        if (item.name == first) {
          dropProfessionValue = i;
        }
      }
      i += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBarAllUsers(),
      ),
      body: SizedBox(
        height: height,
        child: Stack(children: [
          Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/background/new_user.png',
                width: width,
              )),
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/big_icons/new_user_avatar.png',
                    height: 70,
                  ),
                  Text("${widget.user.surname} ${widget.user.name}",
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 20,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 3,
                  ),
                  Text("+${widget.user.phone}",
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 21,
                  ),
                  SizedBox(
                    width: width - 40,
                    child: const Text("Выберите юридическое лицо",
                        style: TextStyle(
                            color: mySet.second,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: mySet.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: width - 40,
                    child: DropdownButton<int>(
                      items: dropCompanyItems,
                      value: dropCompanyValue,
                      hint: const Text('Название оргонизации'),
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                      underline: const SizedBox(),
                      isExpanded: true,
                      menuMaxHeight: 300,
                      onChanged: (value) {
                        dropCompanyValue = value;
                        if (value != null) {
                          pickCompany = companyList[value];
                          updateDropProfession(pickCompany?.companyTypeId ?? 0);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: width - 40,
                    child: const Text("Выберите должность",
                        style: TextStyle(
                            color: mySet.second,
                            fontSize: 14,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: mySet.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: width - 40,
                    child: DropdownButton<int>(
                      items: dropProfessionItems,
                      value: dropProfessionValue,
                      hint: const Text('Должность'),
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                      underline: const SizedBox(),
                      isExpanded: true,
                      menuMaxHeight: 300,
                      onChanged: (value) {
                        enableBtn = value != null && dropCompanyValue != null ? true : false;
                        dropProfessionValue = value;
                        pickProfession = pickListPro[value ?? 0];
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UniversalBtn(
                        enable: enableBtn,
                        text: 'Подтвердить',
                        textStyle: const TextStyle(
                            color: mySet.white,
                            fontSize: 16,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400),
                        onTap: () {
                          api.updateProfession(widget.user.userId,
                              pickProfession.professionId,
                              pickCompany?.companyId ?? 0);
                          api.sendPush(
                              'Обновление статуса',
                              'Поздравляем! Модератор успешно обработал вашу заявку на регистрацию и назначил вам организацию и должность.',
                              'Поздравляем! Модератор успешно обработал вашу заявку на регистрацию и назначил вам организацию и должность.',
                              'update profession',
                              widget.user.userId
                          );
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>
                             const AdminAllUsersInfo()),);
                        },
                      ),
                      UniversalBtn(
                        text: 'Забанить',
                        blackColor: false,
                        onTap: () {
                          print('Забанить');
                        },
                      ),
                    ],
                  )
                ]),
          ),
        ]),
      ),
    );
  }
}
