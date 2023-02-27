import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class CreateNewContract extends StatefulWidget {
  const CreateNewContract({super.key});

  @override
  State<CreateNewContract> createState() => _CreateNewContractState();
}

class _CreateNewContractState extends State<CreateNewContract> {
  bool textHintEmpty = true;
  ApiSVD api = ApiSVD();
  int? valueCompany, valueObject;
  List<Company> allCompany = [];
  List<DropdownMenuItem<int>> dropCompanyItems = [];

  List<CompanyObject> allObjects = [];
  List<DropdownMenuItem<int>> dropObjectsItems = [];

  Company? pickCompany;
  Company? pickObject;

  @override
  void initState() {
    super.initState();
    getApiCompanyList();
  }

  void getApiCompanyList() async {
    allCompany = await api.getCompanyList();
    dropCompanyItems.clear();
    for (Company company in allCompany) {
      dropCompanyItems.add(DropdownMenuItem(
        value: company.companyId,
        child: Text(company.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
      ));
    }
    setState(() {});
  }

  void getObjectList(int companyId) async {
    allObjects = await api.objectsInCompany(companyId);
    if (allObjects.isEmpty) {
      return dropObjectsItems.clear();
    }
    dropObjectsItems.clear();
    for (CompanyObject object in allObjects) {
      dropObjectsItems.add(DropdownMenuItem(
        value: object.objectId,
        child: Text(object.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                color: mySet.main,
                child: Image.asset(
                  'assets/app_bar/new_doc.png',
                  height: 120,
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Введите номер счёта',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFieldWithoutTopHint(
                      textEmpty: textHintEmpty,
                      hintText: 'Номер счета',
                      onChanged: (text) {
                        textHintEmpty = text.isEmpty ? true : false;

                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Выберите юридическое лицо',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: mySet.unSelect,
                            blurRadius: 5,
                            offset: Offset(-3, 3))
                      ], color: mySet.white
                          // border: Border.all(color: mySet.main, width: 1)
                          ),
                      width: width - 40,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          'Название организации',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: dropCompanyItems,
                        value: valueCompany,
                        onChanged: (value) {
                          valueCompany = value;
                          valueObject = null;
                          if (value != null) {
                            pickCompany = allCompany[value];
                            getObjectList(pickCompany!.companyId);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Выберите объект',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: mySet.unSelect,
                            blurRadius: 5,
                            offset: Offset(-3, 3))
                      ], color: mySet.white
                          // border: Border.all(color: mySet.main, width: 1)
                          ),
                      width: width - 40,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          'Название объекта',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: dropObjectsItems,
                        value: valueObject,
                        onChanged: (value) {
                          valueObject = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: width,
                      child: TextButton(
                          onPressed: (){},
                          child: const Text('Добавить статью затрат',
                            style: TextStyle(fontSize: 16, color: mySet.main, decoration: TextDecoration.underline),)
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      'Выберите контрагента',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: mySet.unSelect,
                            blurRadius: 5,
                            offset: Offset(-3, 3))
                      ], color: mySet.white
                        // border: Border.all(color: mySet.main, width: 1)
                      ),
                      width: width - 40,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          'Название организации',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: dropCompanyItems,
                        value: valueCompany,
                        onChanged: (value) {
                          valueCompany = value;
                          valueObject = null;
                          if (value != null) {
                            pickCompany = allCompany[value];
                            getObjectList(pickCompany!.companyId);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Ведите ваш комментарий',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFieldWithoutTopHint(
                      expanded: true,
                      height: 100,
                      textEmpty: textHintEmpty,
                      hintText: 'Коментарий (необязательно)',
                      onChanged: (text) {
                        textHintEmpty = text.isEmpty ? true : false;

                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child:
              UniversalBtn(
                  width: width - 40,
                  text: 'Далее',
                  textStyle: const TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                  onTap: () {}),)
            ],
          ),
        ),
      ),
    );
  }
}
