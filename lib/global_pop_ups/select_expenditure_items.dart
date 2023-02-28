
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/text_field_search.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

import '../custom_widgets/default_btn.dart';

class SelectExpenditureItems extends StatefulWidget{
  final CompanyObject pickObject;
  const SelectExpenditureItems({super.key, required this.pickObject});

  @override
  State<SelectExpenditureItems> createState() => _SelectExpenditureItemsState();
}

class _SelectExpenditureItemsState extends State<SelectExpenditureItems> {
  List<SpendingConst> allSpendingConst = [];
  List<SpendingConst> allSpendingConstDb = [];
  final ApiSVD api = ApiSVD();

  @override
  void initState() {
    updateSpendingConst();
    super.initState();
  }

  void updateSpendingConst() async {
    allSpendingConstDb = await api.getSpendingConst(widget.pickObject.objectId);
    allSpendingConst = allSpendingConstDb;
    setState(() {});
  }

  void updateSearch(String text){
    List<SpendingConst> spendingConst = [];
    for (SpendingConst one in allSpendingConstDb) {
      String line = '${one.spendingId} ${one.name}'.toLowerCase();
      if (line.contains(text)) {
        spendingConst.add(one);
      }
    }
    allSpendingConst = spendingConst;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mySet.background,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 470,
        width: 315,
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerRight,
              width: 280,
              height: 20,
              child: IconButton(
                icon: const Icon(Icons.close, size: 30,),
                onPressed: () {
                  Navigator.of(context).pop();
                },),
            ),
            const SizedBox(height: 15,),
            const Text('Выберите', style: TextStyle(
                color: mySet.main,
                fontSize: 24,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const Text('статью затрат', style: TextStyle(
                color: mySet.main,
                fontSize: 24,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const SizedBox(height: 26,),
            const Text('Введите название статьи затрат', style: TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            SearchTextField(
              hintText: '1-1 Фундамент',
              onChanged: (text) {
                if (text.isEmpty) {
                  allSpendingConst = allSpendingConstDb;
                  setState(() { });
                } else {
                  updateSearch(text.toLowerCase());
                }
                setState(() {});
              },
              width: 275,
            ),
            const SizedBox(height: 10,),
            allSpendingConst.isEmpty ? Container(
              alignment: Alignment.center,
              height: 180,
                width: 275,
              child: const Text('Загрузка...',
                  style: TextStyle(color: mySet.main),
            )) :
            SizedBox(
              height: 180,
              width: 315,
              child: ListView(
              children: [
                for (SpendingConst one in allSpendingConst) (
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      padding: const EdgeInsets.only(left: 10),
                      width: 275,
                      height: 38,

                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        color: mySet.white,
                        boxShadow: [BoxShadow(
                            color: mySet.input,
                            blurRadius: 5,
                            offset: Offset(-3, 3)
                        )]
                      ),
                      child: Text('${one.spendingId} ${one.name}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: mySet.main, fontSize: 14),),
                    )
                )
              ],
            ),
            ),
            const SizedBox(height: 20,),
            UniversalBtn(
                width: 275,
                text: 'Далее',
                textStyle: const TextStyle(
                    color: mySet.white,
                    fontSize: 16,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}