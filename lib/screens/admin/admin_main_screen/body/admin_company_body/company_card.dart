
import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/global_const.dart';
import 'package:flutter/material.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/main_admin_inherit.dart';


class CompanyListCard extends StatefulWidget {
  final Company company;
  const CompanyListCard({super.key, required this.company});

  @override
  State<CompanyListCard> createState() => _CompanyListCardState();
}

class _CompanyListCardState extends State<CompanyListCard> {
  bool pres = false;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (a) {
        pres = true;
        setState(() { });
      },
      onTapCancel: () {
        pres = false;
        setState(() { });
      },
      onTapUp: (a){
        pres = false;

        setState(() { });
      },
      onTap: () {
        MainAdminInherit.of(context)?.updateAllUsersCompany(widget.company.companyId);
        MainAdminInherit.of(context)?.setNewCompanyWidgetToBody(widget.company);
      },
      child: Column(
        children: [
          const SizedBox(height: 18,),
          Container(
            height: 38,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(
                color: mySet.input,
                blurRadius: 5,
                offset: Offset(-3, 3)
            )],
              color: pres ? mySet.shadow : mySet.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.company.name,
                    style: const TextStyle(
                        color: mySet.main,
                        fontSize: 16,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
                Text(widget.company.typeName,
                    style: const TextStyle(
                        color: mySet.second,
                        fontSize: 14,
                        fontFamily: "Italic",
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
