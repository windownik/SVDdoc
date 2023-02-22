
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String? fileName;
  int? fileId;
  final ApiSVD api = ApiSVD();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool emptyName = true;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBarNewObject(),
      ),
      body: Column(
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
          fileName == null ? const Text(
            'Файл не загружен.',
            style: TextStyle(
                color: mySet.main,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.start,
          ) : Text(
            fileName!,
            style: const TextStyle(
                color: mySet.main,
                fontSize: 16,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        const SizedBox(height: 16,),
          Image.network('http://185.51.247.27:10020/file_download?file_id=1'),
          UniversalBtn(
            width: width-40,
            text: 'Загрузить статьи затрат',
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              var image = await _picker.pickImage(source: ImageSource.gallery);
              // print([1111111111111111, image?.name]);
            },
            blackColor: false,
          )

        ],
      ),
    );
  }
}