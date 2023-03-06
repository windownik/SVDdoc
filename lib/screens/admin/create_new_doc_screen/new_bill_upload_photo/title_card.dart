


import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/global_const.dart';

class TitleCard extends StatelessWidget{
  final String text;
  const TitleCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mySet.main,
      margin: const EdgeInsets.only(top: 12,),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
      child: Text(
        text,
        style: const TextStyle(
            color: mySet.white,
            fontSize: 14,
            fontFamily: "Italic",
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
