
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class ObjectCompanyCard extends StatefulWidget{
  final Company company;
  const ObjectCompanyCard({super.key, required this.company});

  @override
  State<ObjectCompanyCard> createState() => _ObjectCompanyCardState();
}

class _ObjectCompanyCardState extends State<ObjectCompanyCard> {
  bool pres = false;
  @override
  Widget build(BuildContext context) {
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
      onTap: () {},
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.company.name, style: const TextStyle(
                color: mySet.main,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
            Text(getCount(widget.company.countObject),
                style: const TextStyle(
                color: mySet.second,
                fontSize: 14,
                fontFamily: "Italic",
                fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

String getCount(int countObject) {
  if (countObject == 0) {
    return "Нет объектов";
  } else if (countObject == 1) {
    return "1 объект";
  } else if (countObject%5 == 0) {
    return "$countObject объектов";
  } else if (countObject%6 == 0) {
    return "$countObject объектов";
  } else if (countObject%7 == 0) {
    return "$countObject объектов";
  } else if (countObject%8 == 0) {
    return "$countObject объектов";
  } else if (countObject%9 == 0) {
    return "$countObject объектов";
  } else {
    return "$countObject объекта";
  }
}