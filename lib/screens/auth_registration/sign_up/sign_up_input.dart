import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class SignUpInput {
  TextStyle style = const TextStyle(color: mySet.main);
  InputDecoration? inputDecor;
  String erText, hintText;
  bool ifError = false;

  SignUpInput(
      {required this.erText, required this.hintText, required this.ifError}) {
    inputDecor = InputDecoration(
        contentPadding: const EdgeInsets.all(10),
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
        labelText: hintText,
        labelStyle: const TextStyle(fontSize: 14, color: mySet.input));
  }
}

class PasswordInput {
  TextStyle style = const TextStyle(color: mySet.main);
  InputDecoration? inputDecor;
  String erText, hintText;
  bool ifError = false;
  Icon icon;
  VoidCallback onPressed;

  PasswordInput(
      {required this.erText,
      required this.hintText,
      required this.ifError,
      required this.icon,
      required this.onPressed}) {
    inputDecor = InputDecoration(
      contentPadding: const EdgeInsets.all(10),
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
      labelText: hintText,
      labelStyle: const TextStyle(fontSize: 14, color: mySet.input),
      suffixIcon: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
      suffixIconColor: mySet.shadow,
    );
  }
}
