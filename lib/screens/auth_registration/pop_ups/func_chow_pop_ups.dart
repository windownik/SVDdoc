
import 'package:flutter/material.dart';
import 'no_inet.dart';

void showPopDefault (Object exception, context) {
  String e = exception.toString();
  if (e == 'Connection failed') {
    showDialog(
        context: (context),
        builder: (BuildContext context) {
          return const NoInetConnection();
        });
  }
}

void showPopLoading (Object exception, context) {
  String e = exception.toString();
  if (e == 'Connection failed') {
    showDialog(
        context: (context),
        builder: (BuildContext context) {
          return const NoInetConnection();
        });
  }
}