import 'package:flutter/material.dart';
import 'package:svd_doc/logic/global_const.dart';

import 'login_inherit.dart';
import 'login_input_bar.dart';

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginWithPassword> {

  @override
  Widget build(BuildContext context) {
    LoginModel model = LoginModel();
    return Scaffold(
      backgroundColor: mySet.background,
      body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: LoginModelInherit(
              model: model,
              child: const LoginInputBar(),
            ),
          ),
    );
  }
}