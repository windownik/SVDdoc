import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';

class UsersCompanyCard extends StatefulWidget {
  final User user;
  final Company company;
  const UsersCompanyCard({super.key, required this.user, required this.company});

  @override
  State<UsersCompanyCard> createState() => _UsersCompanyCardState();
}

class _UsersCompanyCardState extends State<UsersCompanyCard> {
  bool presCard = false;
  bool presDelete = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: mySet.input,
                  blurRadius: 5,
                  offset: Offset(-3, 3))
            ],
          ),
          width: width,
          child: Row(
            children: [
              GestureDetector(
                onTapDown: (a) {
                  presCard = true;
                  setState(() {});
                },
                onTapCancel: () {
                  presCard = false;
                  setState(() {});
                },
                onTapUp: (a) {
                  presCard = false;

                  setState(() {});
                },
                onTap: () {},
                child: Container(
                  height: 38,
                  width: width-78,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                    color: presCard ? mySet.shadow : mySet.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.user.surname} ${widget.user.name}",
                          style: const TextStyle(
                              color: mySet.main,
                              fontSize: 16,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w400)),
                      Text(widget.user.profession,
                          style: const TextStyle(
                              color: mySet.second,
                              fontSize: 14,
                              fontFamily: "Italic",
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTapDown: (a) {
                  presDelete = true;
                  setState(() {});
                },
                onTapCancel: () {
                  presDelete = false;
                  setState(() {});
                },
                onTapUp: (a) {
                  presDelete = false;

                  setState(() {});
                },
                onTap: () {},
                child: Container(
                    height: 38,
                    width: 38,
                    alignment: Alignment.center,
                    color: presDelete ? mySet.shadow : mySet.white,
                    child: const Icon(
                        Icons.delete_forever,
                        color: Color.fromRGBO(176, 112, 112, 1),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
