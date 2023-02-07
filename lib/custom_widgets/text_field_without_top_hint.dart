
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class TextFieldWithoutTopHint extends StatelessWidget{
  const TextFieldWithoutTopHint({
    super.key,
    this.fieldController,
    this.errorText,
    this.keyboardType,
    this.height = 40,
    this.width = 400,
    required this.hintText,
    this.textEmpty = true,
    this.onChanged,
  });

  final TextEditingController? fieldController;
  final String? errorText;
  final String hintText;
  final bool textEmpty;
  final TextInputType? keyboardType;
  final double height, width;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: mySet.white,
              boxShadow: [BoxShadow(
                color: mySet.input,
                blurRadius: 5,
                offset: Offset(-3, 3)
            )]
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: Text(hintText, style: TextStyle(fontSize: 14, color: textEmpty ? mySet.input : Colors.transparent)),

          ),
          TextField(
            controller: fieldController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 1, color: mySet.red),
                ),
                errorText: errorText,
                errorStyle: const TextStyle(color: mySet.red),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 1, color: mySet.input),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 1, color: mySet.input),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(width: 1, color: mySet.main),
                ),
                // labelText: "labelText",
                // labelStyle: const TextStyle(fontSize: 14, color: mySet.input)
            ),
            cursorColor: mySet.main,
            keyboardType: keyboardType,
            onTap: () { },
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}