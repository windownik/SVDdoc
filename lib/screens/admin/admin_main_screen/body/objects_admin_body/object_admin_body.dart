
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'object_company_card.dart';


class ObjectAdminBody extends StatefulWidget {
  const ObjectAdminBody({super.key});
  @override
  State<ObjectAdminBody> createState() => _ObjectAdminBodyState();
}

class _ObjectAdminBodyState extends State<ObjectAdminBody> {
  final ApiSVD api = ApiSVD();
  final TextEditingController controller = TextEditingController();
  List<Company> allCompany = [];
  List<Company> allCompanyConst = [];

  @override
  void initState() {
    super.initState();
    getApiNewCompany();
  }

  void getApiNewCompany() async {
    allCompany = await api.getCompanyList();
    allCompanyConst = allCompany;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (allCompany.isNotEmpty || allCompany.isEmpty && allCompanyConst.isNotEmpty) {
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('Выберите юридическое лицо',
                  style: TextStyle(
                      color: mySet.main,
                      fontSize: 18,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width-70,
                    child: TextField(
                      onChanged: (text) {
                        allCompany = allCompanyConst;
                        if (text.isEmpty) {
                          setState(() {});
                        } else {
                          text = text.toLowerCase();
                          List<Company> newAllCompany = [];
                          for (Company company in allCompany) {
                            if (company.name.toLowerCase().contains(text)) {
                              newAllCompany.add(company);
                            }
                          }
                          allCompany = newAllCompany;
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
                          borderSide: BorderSide(width: 1, color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.search_outlined, color: mySet.second,),
                ],
              ),
              Container(width: width, height: 1, color: mySet.input,),
              allCompany.isEmpty && allCompanyConst.isNotEmpty ?
              (Center(
                child: Column(
                  children: const [
                    SizedBox(height: 30,),
                    Text('Ничего не смог найти',
                        style: TextStyle(
                            color: mySet.input,
                            fontSize: 20,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),
                    Icon(Icons.search_off, color: mySet.input, size: 110,)
                  ],
                ),
              )
              ) : Column(children: [
                for (Company company in allCompany) (
                    ObjectCompanyCard(company: company,)
                )
              ],
              )
            ]
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
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
    );
  }
}
