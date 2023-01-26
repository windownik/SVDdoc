import 'package:flutter/material.dart';
import 'package:svd_doc/global_const.dart';
import 'package:svd_doc/screens/sign_up_second/sign_up_second_inherit.dart';
import 'package:svd_doc/screens/sign_up_second/sign_up_second_input_bar.dart';


class SignUpSecond extends StatefulWidget {
  const SignUpSecond({super.key});

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {

  @override
  Widget build(BuildContext context) {
    SignUpSecondModel model = SignUpSecondModel();
    return Scaffold(
      backgroundColor: mySet.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SignUpSecondInherited(
              model: model,
              child: const SignUpSecondInputBar(),
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
