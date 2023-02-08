
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/main_admin_inherit.dart';

import 'company_card.dart';


class AllCompanyListBody extends StatefulWidget {
  const AllCompanyListBody({super.key});
  @override
  State<AllCompanyListBody> createState() => _AllCompanyListBodyState();
}

class _AllCompanyListBodyState extends State<AllCompanyListBody> {

  final ApiSVD api = ApiSVD();
  List<Company> allCompany = [];

  @override
  void initState() {
    super.initState();
    getApiNewUsers();
  }

  void getApiNewUsers() async {
    allCompany = await api.getCompanyList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (allCompany.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  Center(
                    child: Text('У вас ${allCompany.length} юридических лица',
                        style: const TextStyle(
                            color: mySet.main,
                            fontSize: 16,
                            fontFamily: "Italic",
                            fontWeight: FontWeight.w300)),
                  ),
                  for (var i in allCompany) (CompanyListCard(company: i,)),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            UniversalBtn(
              text: 'Создать новое юридическое лицо',
              onTap: () {
                MainAdminInherit.of(context)?.setNewCompanyWidgetToBody();
              },
              textStyle: const TextStyle(color: mySet.white),
              width: double.infinity,
            ),
            const SizedBox(height: 27,),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: height-320,
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
            ),
            const Spacer(),
            UniversalBtn(
              text: 'Создать новое юридическое лицо',
              onTap: () {
                MainAdminInherit.of(context)?.setNewCompanyWidgetToBody();
              },
              textStyle: const TextStyle(color: mySet.white),
              width: double.infinity,
            ),
            const SizedBox(height: 27,),
          ],
        ),
      ),
    );
  }
}
