import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/global_pop_ups/please_pick_object.dart';
import 'package:svd_doc/global_pop_ups/select_expenditure_items.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_upload_photo/new_bill_%20upload_photo.dart';

class CreateNewContract extends StatefulWidget {
  const CreateNewContract({super.key});

  @override
  State<CreateNewContract> createState() => _CreateNewContractState();
}

class _CreateNewContractState extends State<CreateNewContract> {
  bool textHintEmpty = true;
  UserDataBase  db = UserDataBase();
  ApiSVD api = ApiSVD();
  TextEditingController commentController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  int? valueInvestorCompany, valueObject, valueContrAgentCompany;
  List<Company> investorCompany = [], contrAgentCompany = [];
  List<DropdownMenuItem<int>> dropInvestorCompanyItems = [];
  List<DropdownMenuItem<int>> dropContrAgentCompanyItems = [];

  List<CompanyObject> allObjects = [];
  List<DropdownMenuItem<int>> dropObjectsItems = [];

  Company? pickInvestorCompany, pickContrAgentCompany, svdCompany;
  CompanyObject? pickObject;

  List<SpendingConst> spendingConstList = [];

  @override
  void initState() {
    super.initState();
    getInvestorCompanyList();
    getContragentCompanyList();
  }

  void getInvestorCompanyList() async {
    investorCompany = await api.getCompanyListType(2);
    dropInvestorCompanyItems.clear();
    int i = 0;
    for (Company company in investorCompany) {
      dropInvestorCompanyItems.add(DropdownMenuItem(
        value: i,
        child: Text(company.name,
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

  void getContragentCompanyList() async {
    contrAgentCompany = await api.getCompanyListType(3);
    svdCompany = (await api.getCompanyListType(1))[0];
    dropContrAgentCompanyItems.clear();
    int i = 0;
    for (Company company in contrAgentCompany) {
      dropContrAgentCompanyItems.add(DropdownMenuItem(
        value: i,
        child: Text(company.name,
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

  void getObjectList(int companyId) async {
    allObjects = await api.objectsInCompany(companyId);
    if (allObjects.isEmpty) {
      return dropObjectsItems.clear();
    }
    dropObjectsItems.clear();
    int i = 0;
    for (CompanyObject object in allObjects) {
      dropObjectsItems.add(DropdownMenuItem(
        value: i,
        child: Text(object.name,
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;

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
          // height: height-160,
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
                      fieldController: numberController,
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
                        items: dropInvestorCompanyItems,
                        value: valueInvestorCompany,
                        onChanged: (value) {
                          valueInvestorCompany = value;

                          if (value != null) {
                            pickInvestorCompany = investorCompany[value];
                            getObjectList(pickInvestorCompany!.companyId);
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
                          if (value != null) {
                            pickObject = allObjects[value];
                          } else {
                            pickObject = null;
                          }
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
                          onPressed: () async {
                            if (pickObject == null) {
                              showDialog(
                                  context: (context),
                                  builder: (BuildContext context) {
                                    return const PleasePickObject();
                                  });
                            } else {
                              SpendingConst? data = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectExpenditureItems(pickObject: pickObject!,);
                                  }
                              );
                              if (data != null) {
                                spendingConstList.add(data);
                                setState(() {});
                              }
                            }

                          },
                          child: const Text('Добавить статью затрат',
                            style: TextStyle(fontSize: 16,
                                color: mySet.main,
                                decoration: TextDecoration.underline),)
                      ),
                    ),
                    for (SpendingConst spendingConst in spendingConstList)
                      SpendingConstCard(spendingConst: spendingConst,
                        onTap: () {
                        spendingConstList.remove(spendingConst);
                        setState(() { });
                        },
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
                        items: dropContrAgentCompanyItems,
                        value: valueContrAgentCompany,
                        onChanged: (value) {
                          valueContrAgentCompany = value;
                          if (value != null) {
                            pickContrAgentCompany = contrAgentCompany[value];
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
                      fieldController: commentController,
                      onChanged: (text) {
                        textHintEmpty = text.isEmpty ? true : false;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 110,
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
                  onTap: () {
                    if (pickInvestorCompany != null || pickContrAgentCompany != null || pickObject != null || commentController.text.isNotEmpty || spendingConstList.isNotEmpty) {

                      User user = db.getUser();

                      BillDocument billDoc = BillDocument(
                          billNumber: numberController.text,
                          comment: commentController.text,
                          investor: pickInvestorCompany!,
                          contRAgent: pickContrAgentCompany!,
                          techCustomer: svdCompany!,
                          spendingConstList: spendingConstList,
                          pickObject: pickObject!,
                          creator: user
                      );
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            CreateNewBillDoc(billDocument: billDoc,)),
                      );
                    }
                  }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SpendingConstCard extends StatefulWidget{
  final SpendingConst spendingConst;
  final GestureTapCallback onTap;
  const SpendingConstCard({super.key, required this.spendingConst, required this.onTap});

  @override
  State<SpendingConstCard> createState() => _SpendingConstCardState();
}

class _SpendingConstCardState extends State<SpendingConstCard> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {

    String name = "${widget.spendingConst.spendingId} ${widget.spendingConst.name}";
    name = name.length > 25 ? name.substring(0, 25) : name;

    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: (tap) {
        pres = false;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapDown: (tap) {
        pres = true;
        setState(() { });
      },
      child: Container(
        color: pres ? mySet.shadow : Colors.transparent,
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text(
            name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Сумма ${widget.spendingConst.priceInDoc} руб.",
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }
}