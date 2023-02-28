
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class SearchTextField extends StatelessWidget{
  final ValueChanged<String>? onChanged;
  final double width;
  final String hintText;
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.width = 300,
    this.hintText = 'Поиск',

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width - 40,
                  child: TextField(
                    onChanged: onChanged,
                    controller: controller,
                    cursorColor: mySet.main,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      focusColor: mySet.main,
                      hintText: hintText,
                      hintStyle: const TextStyle(color: mySet.input),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: Colors.transparent),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: Colors.transparent),
                      ),
                    ),
                  ),
                ),

                const Icon(
                  Icons.search_outlined,
                  color: mySet.second,
                ),
              ],
            ),
          Container(
            width: width-10,
            height: 1,
            color: mySet.second,
          )
        ],
      ),
    );
  }

}