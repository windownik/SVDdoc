
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/custom_widgets/text_field_without_top_hint.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/logic/data_base.dart';

import 'app_bar_for_new_object.dart';

class CreateNewObjectScreen extends StatefulWidget{
  final Company company;
  const CreateNewObjectScreen({super.key, required this.company});

  @override
  State<CreateNewObjectScreen> createState() => _CreateNewObjectScreenState();
}

class _CreateNewObjectScreenState extends State<CreateNewObjectScreen> {
  String fileName = '';
  bool errorText = false;
  int? fileId;
  String filePath = '';
  bool red = false, pres = false;
  final ApiSVD api = ApiSVD();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool emptyName = true;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBarNewObject(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: mySet.background,
          height: height-160,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                  child: Image.asset('assets/background/add_user_to_company.png', width: width,)),
              Column(
                children: [
                  const SizedBox(height: 16,),
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
                    ],),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(width: width-40,
                    child: const Text(
                      'Введите название нового объекта',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFieldWithoutTopHint(
                    fieldController: _controller,
                    width: width-40,
                    hintText: '',
                    textEmpty: emptyName,
                    onChanged: (text){
                      if (text.isEmpty) {
                        emptyName = true;
                      } else {
                        emptyName = false;
                      }
                      setState(() { });
                    } ,
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: width-40,
                    child: fileName.isEmpty ? const Text(
                      'Файл не загружен.',
                      style: TextStyle(
                          color: mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ) : Text(
                      fileName,
                      style: TextStyle(
                          color: red ? mySet.red : mySet.main,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),

                const SizedBox(height: 16,),

                  UniversalBtn(
                    width: width-40,
                    text: 'Загрузить статьи затрат',
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      filePath = result.files.single.path!;
                      List<String> data = filePath.split('/');
                      fileName = data.last;

                      if (fileName.contains('.xlsx')) {
                        red = false;
                      } else {
                        red = true;
                        fileName = 'Неверный формат файла';
                      }
                      setState(() { });
                      // await api.sendFile(1, widget.company.companyId, result.files.single.path!);
                    },
                    blackColor: false,
                  ),
                  errorText ? Column(children: const [
                    SizedBox(height: 16,),
                    Text(
                      'Неверно заполненны поля.',
                      style: TextStyle(
                          color: mySet.red,
                          fontSize: 16,
                          fontFamily: "Italic",
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 16,)
                  ],) : const SizedBox(height: 16,),
                  UniversalBtn(
                    width: width-40,
                    text: 'Создать',
                    textStyle: const TextStyle(
                        color: mySet.white,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400),
                    onTap: () async {
                      if (filePath.isEmpty || red || pres || _controller.text.isEmpty) {
                        errorText = true;
                        setState(() { });
                        return;
                      } else {
                        errorText = false;
                      }
                      pres = true;
                      setState(() { });
                      int objectId = await api.createObject(_controller.text, widget.company.companyId);
                      await api.sendFileObject(objectId, widget.company.companyId, filePath);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}