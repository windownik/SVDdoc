
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

import '../custom_widgets/default_btn.dart';

class SpendingConstInputPrice extends StatefulWidget{
  final CompanyObject pickObject;
  final SpendingConst spendingConst;
  const SpendingConstInputPrice({
    super.key,
    required this.pickObject,
    required this.spendingConst
  });

  @override
  State<SpendingConstInputPrice> createState() => _SpendingConstInputPriceState();
}

class _SpendingConstInputPriceState extends State<SpendingConstInputPrice> {
  List<SpendingConst> allSpendingConst = [];
  List<SpendingConst> allSpendingConstDb = [];
  int price = 0;
  final ApiSVD api = ApiSVD();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mySet.background,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 470,
        width: 315,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                const Text('Статья затрат', style: TextStyle(
                    color: mySet.main,
                    fontSize: 24,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 275,
                  child: Text("${widget.spendingConst.spendingId} ${widget.spendingConst.name}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                      color: mySet.main,
                      fontSize: 18,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 26,),
                const Text('Введите сумму трат по статье', style: TextStyle(
                    color: mySet.main,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w300)),
                const SizedBox(height: 5,),
                TextFieldWithoutTopHint(
                  hintText: '10 000',
                  onChanged: (text) {
                    price = int.parse(text);
                  },
                  width: 275,
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: UniversalBtn(
                  width: 275,
                  text: 'Добавить',
                  textStyle: const TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                  onTap: () {
                    // print(price);
                    // NewBillInherit.of(context)?.updatePrice(price);
                    // NewBillInherit.of(context)?.updateSpendingConstList(widget.spendingConst);
                    Navigator.pop(context, price);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}