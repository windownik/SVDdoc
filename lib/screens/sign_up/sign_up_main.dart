import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';
import 'package:svd_doc/screens/sign_up/sign_up_first_input_bar.dart';
import 'package:svd_doc/screens/sign_up/sign_up_inherith.dart';

class SignUpFirst extends StatefulWidget {
  const SignUpFirst({super.key});

  @override
  State<SignUpFirst> createState() => _SignUpFirstState();
}

class _SignUpFirstState extends State<SignUpFirst> {

  @override
  Widget build(BuildContext context) {
    SignUpFirstModel model = SignUpFirstModel();
    return Scaffold(
      backgroundColor: mySet.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SignUpFirstInherited(
              model: model,
              child: const SignUpFirstInputBar(),
            ),
          ),
          Positioned(
              left: 10,
              top: 66,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: mySet.main,
                ),
              )),
        ],
      ),
    );
  }
}