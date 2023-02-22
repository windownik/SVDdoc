
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svd_doc/logic/global_const.dart';

class NewDocStartScreen extends StatelessWidget{
  const NewDocStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Image.asset('assets/background/new_doc.png', width: width,)
        ),
        Column(
          children: [
            const SizedBox(height: 16,),
            const Text('Выберите тип нового\nдокумента',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: mySet.main,
                fontSize: 18,
                fontFamily: "Italic",
                fontWeight: FontWeight.w300)),
            const SizedBox(height: 16,),
            CustomBtn(assetsName: 'assets/svg/new_act.svg',
              btnText: 'Счет на оплату',
              onTap: () {
              Navigator.pushNamed(context, '/new_contract');
              },
            ),
            const SizedBox(height: 16,),
            CustomBtn(assetsName: 'assets/svg/new_bill.svg',
              btnText: 'Акт выполненных работ',
              onTap: () {},
            ),
            const SizedBox(height: 16,),
            CustomBtn(
              assetsName: 'assets/svg/new_contract.svg',
              btnText: 'Договор/приложение',
              onTap: () {},
            ),
          ],
        ),

      ],
    );
  }
}

class CustomBtn extends StatefulWidget{
  final GestureTapCallback onTap;
  final String assetsName;
  final String btnText;
  const CustomBtn({super.key,
    required this.assetsName,
    required this.btnText,
    required this.onTap});

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  bool pres = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (tap){
        pres = true;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapUp: (tap) {
        pres = false;
        setState(() { });
      },
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: 124,
        width: width,
        color: Color.fromRGBO(67, 66, 74, pres ? 1: 0.8),
        child: Column(
          children: [
            const SizedBox(height: 18,),
            SvgPicture.asset(
              widget.assetsName,
              semanticsLabel: 'Acme Logo',
              color: mySet.white,
            ),
            const SizedBox(height: 18,),
            Text(
              widget.btnText,
              style: const TextStyle(
                  color: mySet.white,
                  fontSize: 24,
                  fontFamily: "Italic",
                  fontWeight: FontWeight.w300),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}