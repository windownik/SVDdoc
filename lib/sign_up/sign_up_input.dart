import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';

// class SignUpInput extends StatefulWidget{
//   const SignUpInput({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _SignUpInputState();
// }
//
// class _SignUpInputState extends State<SignUpInput>{
//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//       style: ,
//     );
//   }
// }

class SignUpInput {
  TextStyle style = const TextStyle(color: mySet.main);
  InputDecoration? inputDecor;
  String erText, hintText;
  bool ifError = false;

  SignUpInput({required this.erText, required this.hintText, required this.ifError}) {
    inputDecor = InputDecoration(
        contentPadding: const EdgeInsets.all(16),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(width: 1, color: mySet.red),
      ),
        errorText: ifError ? erText : null,
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

        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: mySet.input)

    );


  }
}
