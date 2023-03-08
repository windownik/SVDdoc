
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_upload_photo/spending_const_big_card.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_upload_photo/title_card.dart';
import 'package:svd_doc/screens/admin/create_new_doc_screen/new_bill_users_line/new_bill_users_line_screen.dart';

import 'file_card.dart';

class CreateNewBillDoc extends StatefulWidget {
  const CreateNewBillDoc({super.key, required this.billDocument});
  final BillDocument billDocument;

  @override
  State<CreateNewBillDoc> createState() => _CreateNewContractState();
}

class _CreateNewContractState extends State<CreateNewBillDoc> {
  bool textHintEmpty = true;
  ApiSVD api = ApiSVD();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mySet.background,
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
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 18,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Счет на оплату',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 18,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      '№ ${widget.billDocument.billNumber}',
                      style: const TextStyle(
                          color: mySet.second,
                          fontSize: 18,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              const SizedBox(height: 16,),
              Container(
                padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                width: width-28,
                color: mySet.white,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TitleCard(text: 'Инвестор',),
                    const SizedBox(height: 12,),
                    Text(
                      widget.billDocument.investor.name,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      height: 1,
                      color: mySet.input,
                    ),
                    const TitleCard(text: 'Объект',),
                    const SizedBox(height: 12,),
                    Text(
                      widget.billDocument.pickObject.name,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      height: 1,
                      color: mySet.input,
                    ),
                    const TitleCard(text: 'Статьи затрат',),
                    // const SizedBox(height: 5,),
                    for (SpendingConst one in widget.billDocument.spendingConstList)
                      SpendingConstBigCard(spendingConst: one,),

                    const SizedBox(height: 12,),
                    Container(
                      height: 1,
                      color: mySet.input,
                    ),
                    const TitleCard(text: 'Контрагент',),
                    const SizedBox(height: 12,),
                    Text(
                      widget.billDocument.contRAgent.name,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      height: 1,
                      color: mySet.input,
                    ),
                    const TitleCard(text: 'Технический заказчик',),
                    const SizedBox(height: 12,),
                    Text(
                      widget.billDocument.techCustomer.name,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 12,),
                    Text(
                      "${widget.billDocument.creator.surname} ${widget.billDocument.creator.name}",
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.billDocument.creator.profession,
                      style: const TextStyle(
                          color: mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      widget.billDocument.comment,
                      style: const TextStyle(
                          color: mySet.main,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) => mySet.input),
                ),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                  String filePath = result.files.single.path!;
                  DbFile file = await api.sendFile(filePath);
                  widget.billDocument.addFile(file);
                  setState(() { });
                },
                child: const Text(
                  'Прикрепите файл счёта',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      color: mySet.main,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
              ),
              for (DbFile file in widget.billDocument.filesPhoto)
                FileCard(file: file, onTap: () {
                  widget.billDocument.filesPhoto.remove(file);
                  setState(() { });
                },),
              for (DbFile file in widget.billDocument.filesDoc)
                FileCard(file: file, onTap: () {
                  widget.billDocument.filesDoc.remove(file);
                  setState(() { });
                },),
              const SizedBox(height: 20,),
              UniversalBtn(
                  width: width - 40,
                  text: 'Далее',
                  textStyle: const TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                  onTap: () async {

                    List<User> usersLine = await api.getPreBillLineUsers(
                        investorId: widget.billDocument.investor.companyId,
                        techCustomerId: widget.billDocument.techCustomer.companyId,
                        contRAgent: widget.billDocument.contRAgent.companyId);
                    widget.billDocument.updateUsersLine(usersLine);

                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          NewBillUsersLineScreen(billDocument: widget.billDocument,)),
                    );
                  }),
              const SizedBox(height: 30,),
            ],
          )
        ),
      ),
    );
  }
}
