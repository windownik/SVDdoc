
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'package:svd_doc/logic/global_const.dart';



class NewUsersAdminScreen extends StatelessWidget{
  final User user;
  const NewUsersAdminScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mySet.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: NewUsersFontAppBar(),
      ),
      body: NewUserBody(user: user,),
    );
  }
}

class NewUsersFontAppBar extends StatelessWidget {
  final UserDataBase db = UserDataBase();

  NewUsersFontAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: mySet.main,
      height: 160,
      child: Stack(
        children: [
          Positioned(
              right: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.menu_outlined),
                color: mySet.white,
              )),

          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/app_bar/new_users_admin.png',
                width: width,
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: const Text('Панель\nадминистратора',
                style: TextStyle(
                    color: mySet.white,
                    fontSize: 26,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
          ),
          Positioned(
              left: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: mySet.white,
              )),
        ],
      ),
    );
  }
}

class NewUserBody extends StatefulWidget{
  final User user;
  const NewUserBody({super.key, required this.user});

  @override
  State<NewUserBody> createState() => _NewUserBodyState();
}

class _NewUserBodyState extends State<NewUserBody> {
  List<Company> companyList = [];
  List<String> companyTypeItems = ['Auto', '0', '1', '2', '3', '4', '5', '6'];
  List<DropdownMenuItem<int>> dropCompanyItems = [];
  List<DropdownMenuItem<int>> dropProfessionItems = [];
  int? dropCompanyValue;
  int? dropProfessionValue;
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
      dropCompanyItems.add(DropdownMenuItem(value: i,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(company.name, style: const TextStyle(
                color: mySet.main,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
            Text(company.typeName, style: const TextStyle(
                color: mySet.second,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
          ],
        ),));
      i += 1;
    }
    setState(() { });
  }

  void updateDropCompanyItems(int companyType) {
    List<String> professionSvd = ['Директор', 'Руководитель проекта', 'Инженер тех. надзор', 'Инженер ПТО'];
    List<String> professionRead = ['Директор', 'Технический директор', 'Финансовый директор', 'Секретарь', 'Бухгалтер'];
    List<String> professionNotification = ['Прораб', 'Мастер', 'Подрядчик'];
    List<String> items = professionSvd;
    if (companyType == 2) {
      items = professionRead;
    }
    if (companyType == 3) {
      items = professionNotification;
    }

    dropProfessionItems = [];
    int i = 0;
    for (String item in items) {
      dropProfessionItems.add(DropdownMenuItem(value: i, child: Text(item, style: const TextStyle(
          color: mySet.second,
          fontSize: 16,
          fontFamily: "Italic",
          fontWeight: FontWeight.w400)),));
      i += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Stack(
          children: [
            Positioned(
              bottom: 0,
                child: Image.asset('assets/background/new_user.png', width: width,)
            ),
            Container(
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
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
                const SizedBox(height: 3,),
                Text("+${widget.user.phone}",
                    style: const TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 21,),
                SizedBox(width: width-40,
                  child: const Text("Выберите юридическое лицо",
                    style: TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)
                  ),
                ),
                const SizedBox(height: 8,),

              Container(
               decoration: BoxDecoration(
                    border: Border.all(color: mySet.second, width: 1)
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: width-40,
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
                      Company pickCompany = companyList[value];
                      updateDropCompanyItems(pickCompany.companyTypeId);
                    }

                    setState(() { });
                  },),
              ),

                const SizedBox(height: 18,),

                SizedBox(width: width-40,
                  child: const Text("Выберите должность",
                    style: TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),),
                const SizedBox(height: 8,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: mySet.second, width: 1)
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: width-40,
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
                      dropProfessionValue = value;
                      setState(() { });
                    },),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  UniversalBtn(text: 'Подтвердить', textStyle: const TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                    onTap: () {
                      print('Подтвердить');
                    },),
                    UniversalBtn(text: 'Забанить', blackColor: false,
                      onTap: () {
                      print('Забанить');
                      },),
                ],)
              ]
            ),
          ),]
        ),
    );
  }
}