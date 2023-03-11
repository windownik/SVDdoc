
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/global_const.dart';

import '../logic/data_base.dart';

class CreateNewBill extends StatefulWidget{
  const CreateNewBill({super.key, required this.billDocument});
  final BillDocument billDocument;

  @override
  State<CreateNewBill> createState() => _CreateNewBillState();
}

class _CreateNewBillState extends State<CreateNewBill> {
  String usersIdLine = '';
  String filesIdLine = '';
  ApiSVD api = ApiSVD();
  bool? error;
  int? billId;

  @override
  void initState() {
    createNewBill();
    super.initState();
  }

  void createNewBill() async {

    for (User user in widget.billDocument.usersLine) {
      usersIdLine = "$usersIdLine,${user.userId}";
    }
    for (DbFile file in widget.billDocument.filesDoc) {
      filesIdLine = "$filesIdLine,${file.fileId}";
    }
    for (DbFile file in widget.billDocument.filesPhoto) {
      filesIdLine = "$filesIdLine,${file.fileId}";
    }
    if (usersIdLine.isNotEmpty) {
      usersIdLine = usersIdLine.substring(1, usersIdLine.length);
    }
    if (filesIdLine.isNotEmpty) {
      filesIdLine = filesIdLine.substring(1, filesIdLine.length);
    }
    List<String> spendingOrdersList = [];
    for (SpendingConst one in widget.billDocument.spendingConstList) {
      spendingOrdersList.add('{"spend_id": ${one.mainId},"money": ${one.priceInDoc}}');
    }
    try {
      billId = await api.createBill(
          numberId: widget.billDocument.billNumber,
          companyId: widget.billDocument.investor.companyId,
          objectId: widget.billDocument.pickObject.objectId,
          comment: widget.billDocument.comment,
          usersIdLine: usersIdLine,
          filesIdLine: filesIdLine,
          spendingOrdersList: spendingOrdersList.toString(),
          contRAgentId: widget.billDocument.contRAgent.companyId,
          techCustomerId: widget.billDocument.techCustomer.companyId,
      );
      error = false;
    } catch (e) {
      error = true;
    }

    setState(() { });
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      contentPadding: const EdgeInsets.all(3),
      content: Container(
        height: 230,
        width: 315,
        color: mySet.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(height: 17,),
            Image.asset('assets/big_icons/create_bill.png', height: 120,),
            // const SizedBox(height: 26,),
            error == null || billId == null ?
            const Text('Создаю новый счет', style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w600)) :
            Column(
              children: const [
                Text('Новый счет', style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w600)),
                Text('успешно создан!', style: TextStyle(
                    color: mySet.main,
                    fontSize: 18,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w600)),
              ],
            ),

            const SizedBox(height: 20,),
            billId == null ? LoadingAnimationWidget.prograssiveDots(
              color: mySet.input,
              size: 50,
            ) :
            GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('close');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    height: 30,
                    width: 110,
                    decoration: const BoxDecoration(
                        color: mySet.main,
                        boxShadow: [BoxShadow(
                          color: mySet.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 4.0,
                          // offset: const Offset(-5, 5),
                        )]
                    ),
                    // decoration: ,
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: mySet.white,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
