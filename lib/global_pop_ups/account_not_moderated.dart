
import 'package:flutter/material.dart';
import 'package:svd_doc/custom_widgets/default_btn.dart';
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';

class AccountNotModerated extends StatelessWidget{
  final UserDataBase db = UserDataBase();
  AccountNotModerated({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: mySet.background,
          child: Stack(children: [
            const Positioned(
                right: 0,
                top: 56,
                child: DecorRight()
            ),
            Center(child:
            SizedBox(height: 400, width: 250, child: Column(
              children: [
                Image.asset("assets/big_icons/main_logo.png", width: 200,),
                const Text(
                  'Попробуйте немного позже.',
                  style: TextStyle(
                      color: mySet.main,
                      fontSize: 18,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                const Text(
                  'Ваш аккаунт еще на.',
                  style: TextStyle(
                      color: mySet.second,
                      fontSize: 18,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
                const Text(
                  'проверке у модератора.',
                  style: TextStyle(
                      color: mySet.second,
                      fontSize: 18,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50),
                UniversalBtn(
                  width: 200,
                  textStyle: const TextStyle(
                      color: mySet.white,
                      fontSize: 16,
                      fontFamily: "Italic",
                      fontWeight: FontWeight.w400),
                  text: 'Сменить аккаунт',
                  onTap: () {
                    db.deleteUser();
                    Navigator.of(context).popAndPushNamed('/login');
                  },
                )
              ],
            ))
            ),
            const Positioned(
                left: 0,
                bottom: 0,
                child: DecorLeft()
            ),
          ],)
      ),
    );
  }
}


class DecorRight extends StatelessWidget{
  const DecorRight({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 340,
      child: Stack(
        children: [
          Positioned(
            right: -1, top: 28,
            child: Container(height: 307, width: 51,
              color: mySet.input,),
          ),
          Positioned(
            right: -1, top: 0,
            child: Container(height: 307, width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),
          Positioned(
            right: -1, top: 17,
            child: Container(height: 307, width: 36,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),

        ],
      ),
    );
  }
}

class DecorLeft extends StatelessWidget{
  const DecorLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 170,
      child: Stack(
        children: [
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 140, width: 81,
              color: mySet.input,),
          ),
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 151, width: 96,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),
          Positioned(
            left: -1, bottom: -1,
            child: Container(height: 168, width: 112,
              decoration: BoxDecoration(
                  border: Border.all(color: mySet.main)
              ),),
          ),
        ],
      ),
    );
  }
}