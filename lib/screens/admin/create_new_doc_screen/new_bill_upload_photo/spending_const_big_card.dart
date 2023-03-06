
import 'package:flutter/cupertino.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class SpendingConstBigCard extends StatefulWidget{
  final SpendingConst spendingConst;
  const SpendingConstBigCard({super.key, required this.spendingConst});

  @override
  State<SpendingConstBigCard> createState() => _SpendingConstCardState();
}

class _SpendingConstCardState extends State<SpendingConstBigCard> {
  @override
  Widget build(BuildContext context) {

    String name = "${widget.spendingConst.spendingId} ${widget.spendingConst.name}";
    // name = name.length > 30 ? name.substring(0, 30) : name;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        Text(
          name,
          style: const TextStyle(
              color: mySet.main,
              fontSize: 14,
              fontFamily: "Italic",
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 12,),
        Container(
          color: mySet.shadow,
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.spendingConst.priceInDoc} руб.",
                  style: const TextStyle(
                      color: mySet.main,
                      fontSize: 14,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Остаток ${widget.spendingConst.price - widget.spendingConst.priceInDoc} руб.",
                  style: const TextStyle(
                      color: mySet.second,
                      fontSize: 14,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ],
    );
  }
}