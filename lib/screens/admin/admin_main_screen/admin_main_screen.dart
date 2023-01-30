
import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

class AdminMainScreen extends StatefulWidget{
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mySet.main,
        flexibleSpace: Image.asset('assets/app_bar/admin_main.phg'),
      ),
    );
  }
}