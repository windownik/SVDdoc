
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/main_admin_inherit.dart';

class ObjectCard extends StatefulWidget{
  final CompanyObject object;
  const ObjectCard({super.key, required this.object});

  @override
  State<ObjectCard> createState() => _ObjectCompanyCardState();
}

class _ObjectCompanyCardState extends State<ObjectCard> {

  bool pres = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (tap) {
        pres = true;
        setState(() { });
      },
      onTapUp: (tap) {
        pres = false;
        setState(() {});

      },
      onTapCancel: () {
        pres = false;
        setState(() {});
      },
      onTap: () {
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.only(left: 6, right: 6),
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
                color: pres ? mySet.shadow : mySet.white,
                boxShadow: const [BoxShadow(
                    color: mySet.shadow,
                    blurRadius: 5,
                    offset: Offset(-3, 3)
                )]
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 6,),
                Text("${widget.object.objectId}", style: const TextStyle(
                    color: mySet.input,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w400)),
                const SizedBox(width: 10,),
                Text(widget.object.name, style: const TextStyle(
                        color: mySet.main,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.centerRight,
          //   width: width-40,
          //   child: TextButton(
          //     onPressed: () {  },
          //     child: const Text('редактировать', style: TextStyle(
          //       color: mySet.main,
          //       decoration: TextDecoration.underline,
          //       fontSize: 14,
          //       fontFamily: "Italic",
          //       fontWeight: FontWeight.w400)),
          //   ),
          // )
        ],
      ),
    );
  }
}