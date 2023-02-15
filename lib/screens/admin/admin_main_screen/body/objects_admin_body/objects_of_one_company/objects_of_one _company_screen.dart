
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'object_card.dart';

class AllObjectOfOneCompanyBody extends StatefulWidget {
  final Company company;
  const AllObjectOfOneCompanyBody({super.key, required this.company});
  @override
  State<AllObjectOfOneCompanyBody> createState() => _AllObjectOfOneCompanyBodyState();
}

class _AllObjectOfOneCompanyBodyState extends State<AllObjectOfOneCompanyBody> {
  final ApiSVD api = ApiSVD();
  final TextEditingController controller = TextEditingController();
  List<CompanyObject> allObjects = [];
  List<CompanyObject> allObjectsConst = [];

  @override
  void initState() {
    super.initState();
    getApiNewCompany();
  }

  void getApiNewCompany() async {
    allObjects = await api.objectsInCompany(widget.company.companyId);
    allObjectsConst = allObjects;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    double delHeight = 320;
    if (Platform.isIOS) {
      delHeight = 345;
    }

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    if (allObjects.isNotEmpty ||
        allObjects.isEmpty && allObjectsConst.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: height - delHeight,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(children: [
                    const SizedBox(height: 20,),
                    SizedBox(height: 22,
                      child: Stack(children: [
                        Positioned(
                          top: 12,
                          child: Container(width: width, height: 1, color: mySet.main,),),
                        Center(
                          child: Container(
                            // alignment: Alignment.center,
                            height: 20,
                            color: mySet.background,
                            child: Text("  ${widget.company.name}  ",
                                style: const TextStyle(
                                    color: mySet.main,
                                    fontSize: 19,
                                    fontFamily: "Italic",
                                    fontWeight: FontWeight.w500)),
                          ),)
                      ],),),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text('Выберите объект',
                        style: TextStyle(
                            color: mySet.second,
                            fontSize: 16,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w300)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width - 70,
                          child: TextField(
                            onChanged: (text) {
                              allObjects = allObjectsConst;
                              if (text.isEmpty) {
                                setState(() {});
                              } else {
                                text = text.toLowerCase();
                                List<CompanyObject> newAllCompany = [];
                                for (CompanyObject object in allObjects) {
                                  if (object.name.toLowerCase().contains(text)) {
                                    newAllCompany.add(object);
                                  }
                                }
                                allObjects = newAllCompany;
                                setState(() {});
                              }
                            },
                            controller: controller,
                            cursorColor: mySet.main,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              focusColor: mySet.main,
                              hintText: 'Поиск',
                              hintStyle: TextStyle(color: mySet.input),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.search_outlined,
                          color: mySet.second,
                        ),
                      ],
                    ),
                    Container(
                      width: width,
                      height: 1,
                      color: mySet.input,
                    ),
                    allObjects.isEmpty && allObjectsConst.isNotEmpty
                        ? (Container(
                      height: height - 520,
                      width: width,
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 30,
                          ),
                          Text('Ничего не смог найти',
                              style: TextStyle(
                                  color: mySet.input,
                                  fontSize: 20,
                                  fontFamily: "Italic",
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.search_off,
                            color: mySet.input,
                            size: 110,
                          )
                        ],
                      ),
                    ))
                        : Column(
                      children: [
                        for (CompanyObject object in allObjects)
                          (ObjectCard(
                            object: object,
                          ))
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),

                  ]),
                ),
              ),
            ),
            Container(
              height: 1,
              width: width,
              color: mySet.input,
            ),
            Container(
              height: 80,
              width: width,
              alignment: Alignment.center,
              child: UniversalBtn(
                text: 'Создать новый объект',
                textStyle: const TextStyle(
                    color: mySet.white,
                    fontSize: 16,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),
                onTap: () {},
                width: width - 40,
                height: 44,
              ),
            )
          ],
        ),
      );
    }
    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              height: height-410,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  const Text('У вас нет оргонизаций',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 18,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400)),
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
          ),
        ),
        Column(
          children: [
            Container(
              height: 1,
              width: width - 40,
              color: mySet.input,
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              width: width,
              child: UniversalBtn(
                text: 'Создать новый объект',
                textStyle: const TextStyle(
                    color: mySet.white,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),
                onTap: () {},
                width: width - 40,
                height: 44,
              ),
            )
          ],
        )
      ],
    );
  }
}
