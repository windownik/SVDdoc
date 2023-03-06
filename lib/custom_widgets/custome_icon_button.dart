
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/global_const.dart';

class MyIconButton extends StatefulWidget{
  final GestureTapCallback onTap;
  final Color pressedColor;
  final Color? backgroundColor;
  final Icon icon;
  final double width;
  final double height;
  final bool enable;

  const MyIconButton({
    super.key,
    required this.icon,
    this.pressedColor = mySet.input,
    this.backgroundColor,
    this.enable = true,
    this.width = 40,
    this.height = 50, required this.onTap
  });

  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool press = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (tap) {
          if (widget.enable) {
            press = true;
            setState(() { });
          }
        },
        onTapUp: (tap) {
          if (widget.enable) {
            press = false;
            setState(() {});
          }
        },
        onTapCancel: () {
          if (widget.enable) {
            press = false;
            setState(() {});
          }
        },
        onTap: widget.enable ? widget.onTap : null,
      child: Container(

        decoration: BoxDecoration(
          color: press ? widget.pressedColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        width: widget.width,
        height: widget.height,
        child: widget.icon,
      )
    );
  }
}