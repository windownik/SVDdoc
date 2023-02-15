import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';

import '../main_admin_inherit.dart';

class SmallAdminBar extends StatefulWidget{
  const SmallAdminBar({super.key});

  @override
  State<SmallAdminBar> createState() => _SmallAdminBarState();
}

class _SmallAdminBarState extends State<SmallAdminBar> {
  int pickBtn = 1;

  @override
  Widget build(BuildContext context) {
    pickBtn = (MainAdminInherit.of(context)?.topActiveBtn ?? pickBtn);
    return Container(
      height: 70,
      color: mySet.background,
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LittleAppBarBtn(pres: pickBtn == 0 ? true : false,
              onTap: () {
                pickBtn = 0;
                MainAdminInherit.of(context)?.setAllCompanyListWidgetToBody();
                setState(() { });
              }, text: 'Редактор\nюр. лиц.',),
            Container(height: 30, width: 1, color: mySet.unSelect,),
            LittleAppBarBtn(pres: pickBtn == 1 ? true : false,
              onTap: () {
                pickBtn = 1;
                MainAdminInherit.of(context)?.setNewUsersWidgetToBody();
                setState(() { });
              }, text: 'Пользователи',),
            Container(height: 30, width: 1, color: mySet.unSelect,),
            LittleAppBarBtn(pres: pickBtn == 2 ? true : false,
              onTap: () {
                pickBtn = 2;
                MainAdminInherit.of(context)?.setObjectAdminWidgetToBody();
                setState(() { });
              },
              text: 'Редактор\nобъектов',
              rightAlign: true,
            ),
          ]
      ),
    );
  }
}

class LittleAppBarBtn extends StatefulWidget{
  const LittleAppBarBtn({super.key, required this.pres, required this.onTap, required this.text, this.rightAlign = false});
  final String text;
  final bool pres, rightAlign;
  final GestureTapCallback onTap;

  @override
  State<LittleAppBarBtn> createState() => _LittleAppBarBtnState();
}

class _LittleAppBarBtnState extends State<LittleAppBarBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        color: Colors.transparent,
        child: Text(widget.text,
          style: TextStyle(
              color: widget.pres ? mySet.main : mySet.unSelect,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
          maxLines: 2,
          textAlign: widget.rightAlign ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }
}