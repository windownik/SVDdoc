
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';


class UniversalBtn extends StatefulWidget{
  final double height, width;
  final bool blackColor;
  final String text;
  final GestureTapCallback onTap;
  static const TextStyle style = TextStyle(
      color: mySet.main,
      fontSize: 16,
      fontFamily: "Italic",
      fontWeight: FontWeight.w400);
  final TextStyle textStyle;
  const UniversalBtn({super.key,
    required this.text,
    this.height = 44,
    this.width = 157,
    this.blackColor = true,
    this.textStyle = style, required this.onTap,
  });

  @override
  State<UniversalBtn> createState() => _UniversalBtnState();
}

class _UniversalBtnState extends State<UniversalBtn> {
  bool pres = false;
  Color defaultColor = mySet.main;
  Color presColor = mySet.second;


  @override
  Widget build(BuildContext context) {

    defaultColor = widget.blackColor ? mySet.main : mySet.white;
    presColor = widget.blackColor ? mySet.second : mySet.shadow;

    return GestureDetector(
      onTapDown: (tap) {
        pres = true;
        setState(() { });
      },
      onTapUp: (tap) {
        pres = false;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: pres ? presColor : defaultColor,
            boxShadow: const [BoxShadow(
                color: mySet.unSelect,
                blurRadius: 5,
                offset: Offset(-3, 3)
            )]
        ),
        alignment: Alignment.center,
        child: Text(widget.text, style: widget.textStyle,),
      ),
    );
  }
}