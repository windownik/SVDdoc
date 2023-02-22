

import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class CreateNewContract extends StatefulWidget{
  const CreateNewContract({super.key});

  @override
  State<CreateNewContract> createState() => _CreateNewContractState();
}

class _CreateNewContractState extends State<CreateNewContract> {
  bool textHintEmpty = true;
  ApiSVD api = ApiSVD();
  int? value;
  List<Company> allCompany = [];
  List<DropdownMenuItem<int>> dropItems = [];

  @override
  void initState() {
    super.initState();
    getApiCompanyList();
  }

  void getApiCompanyList() async {
    allCompany = await api.getCompanyList();
    dropItems.clear();
    for (Company company in allCompany) {
      dropItems.add(DropdownMenuItem(
        value: company.companyId,
        child: Text(company.name,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),

      ));
    }
    print(dropItems);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              color: mySet.main,
              child: Image.asset('assets/app_bar/new_doc.png', height: 120,),
            ),
            Container(
              padding: const EdgeInsets.only(top: 55),
              alignment: Alignment.center,
              child: const Text('Новый счёт',
                style: TextStyle(
                    color: mySet.white,
                    fontSize: 26,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),)
          ],
        )
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
              child: Image.asset('assets/background/new_bill.png', width: width,)
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16,),
                const Text('Введите номер счёта', style: TextStyle(
                    color: mySet.main,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),),
                const SizedBox(height: 4,),
                TextFieldWithoutTopHint(
                  textEmpty: textHintEmpty,
                  hintText: 'Номер счета',
                  onChanged: (text) {

                    textHintEmpty = text.isEmpty ? true : false;

                    setState(() { });
                  },
                ),
            const SizedBox(height: 16,),
              // DropdownButton2(
              //   isExpanded: true,
              //   hint: Text(
              //     'Select Item',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              //   items: dropItems,
              //   value: value,
              // ),
                const SizedBox(height: 18,),
              UniversalBtn(
                width: width-40,
                text: 'Далее',
                textStyle: const TextStyle(
                    color: mySet.white,
                    fontSize: 16,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),
                onTap: () {  }
                ),
                const SizedBox(height: 18,),
            ],
            ),
          )
        ],
      ),
    );
  }
}