
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';


class FileCard extends StatefulWidget{
  final DbFile file;
  final GestureTapCallback onTap;
  const FileCard({super.key, required this.file, required this.onTap});

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  bool pres = false;


  @override
  Widget build(BuildContext context) {
    String name = widget.file.name;
    name = name.length > 40 ? "${name.substring(0, 35)}..." : name;

    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: (tap) {
        pres = false;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapDown: (tap) {
        pres = true;
        setState(() { });
      },
      child: Container(
        color: pres ? mySet.input : mySet.shadow,
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                    color: mySet.second,
                    fontSize: 14,
                    fontFamily: "Italic",
                    fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.delete_forever, color: mySet.softRed,)
            ]),
      ),
    );
  }
}
